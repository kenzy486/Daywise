import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> get _userDoc {
    final uid = _auth.currentUser!.uid;
    return _db.collection('users').doc(uid);
  }

  DocumentReference<Map<String, dynamic>> get _profileDoc {
    return _userDoc.collection('profile').doc('data');
  }

  // Save user profile (nickname, goals, city, etc.)
  Future<void> saveProfile(Map<String, dynamic> data) async {
    await _profileDoc.set(data, SetOptions(merge: true));
  }

  // Get user profile
  Future<Map<String, dynamic>?> getProfile() async {
    final doc = await _profileDoc.get();
    if (!doc.exists) return null;
    return doc.data();
  }

  // Export all check-ins as JSON
  Future<String> exportCheckins() async {
    final checkinsSnapshot = await _userDoc.collection('checkins').get();
    final checkins = checkinsSnapshot.docs.map((doc) => doc.data()).toList();
    return jsonEncode(checkins);
  }

  // Export as CSV
  Future<String> exportCheckinsCSV() async {
    final checkinsSnapshot = await _userDoc.collection('checkins').get();
    final checkins = checkinsSnapshot.docs.map((doc) => doc.data()).toList();

    if (checkins.isEmpty) return '';

    // Header
    final headers = checkins[0].keys.join(',');
    var csv = headers + '\n';

    // Rows
    for (final checkin in checkins) {
      final row = checkin.values.map((v) => '"$v"').join(',');
      csv += '$row\n';
    }

    return csv;
  }

  // Share/export entries
  Future<void> shareEntries() async {
    final json = await exportCheckins();
    await Share.share(json, subject: 'DayWise Journal Export');
  }

  // Delete all user data
  Future<void> deleteAllData() async {
    final uid = _auth.currentUser!.uid;

    // Delete checkins
    final checkinsSnapshot = await _userDoc.collection('checkins').get();
    for (final doc in checkinsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete suggestions
    final suggestionsSnapshot = await _userDoc.collection('suggestions').get();
    for (final doc in suggestionsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete profile
    await _profileDoc.delete();
  }

  // Delete account (requires re-authentication)
  Future<void> deleteAccount() async {
    await _auth.currentUser!.delete();
  }
}
