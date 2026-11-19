import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Profile, suggestion progress and data controls for the signed-in user.
class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> get _userDoc => _db.collection('users').doc(_auth.currentUser!.uid);

  DocumentReference<Map<String, dynamic>> get _profileDoc => _userDoc.collection('profile').doc('data');

  CollectionReference<Map<String, dynamic>> get _suggestions => _userDoc.collection('suggestions');

  Future<void> saveProfile(Map<String, dynamic> data) => _profileDoc.set(data, SetOptions(merge: true));

  Future<Map<String, dynamic>?> getProfile() async {
    final doc = await _profileDoc.get();
    return doc.exists ? doc.data() : null;
  }

  /// Suggestion progress for one day: { suggestionId: {status, helpful} }.
  Future<Map<String, dynamic>> getSuggestionStates(String dateId) async {
    final doc = await _suggestions.doc(dateId).get();
    return (doc.data()?['states'] as Map<String, dynamic>?) ?? {};
  }

  Future<void> saveSuggestionStates(String dateId, Map<String, dynamic> states) =>
      _suggestions.doc(dateId).set({'states': states});

  /// All check-ins as pretty JSON, for "Export my entries".
  Future<String> exportCheckinsJson() async {
    final snap = await _userDoc.collection('checkins').orderBy('date').get();
    final rows = snap.docs.map((d) {
      final m = Map<String, dynamic>.from(d.data());
      m.updateAll((k, v) => v is Timestamp ? v.toDate().toIso8601String() : v);
      return m;
    }).toList();
    return const JsonEncoder.withIndent('  ').convert(rows);
  }

  /// "Delete my data": check-ins, suggestion progress and profile.
  Future<void> deleteAllData() async {
    for (final col in ['checkins', 'suggestions']) {
      final snap = await _userDoc.collection(col).get();
      for (var i = 0; i < snap.docs.length; i += 400) {
        final batch = _db.batch();
        for (final d in snap.docs.skip(i).take(400)) {
          batch.delete(d.reference);
        }
        await batch.commit();
      }
    }
    await _profileDoc.delete();
  }
}
