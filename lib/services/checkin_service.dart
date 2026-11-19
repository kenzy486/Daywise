import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/checkin.dart';

class CheckinService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // users/{uid}/checkins for whoever is logged in right now
  CollectionReference<Map<String, dynamic>> get _checkins {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _db.collection('users').doc(uid).collection('checkins');
  }

  // Load one day. Returns null if that day was never logged.
  Future<CheckIn?> getForDate(DateTime day) async {
    final doc = await _checkins.doc(CheckIn.dateId(day)).get();
    if (!doc.exists) return null;
    return CheckIn.fromMap(doc.data()!);
  }

  // Save one day. The document name IS the date,
  // so saving the same day again replaces it (one entry per day).
  Future<void> save(CheckIn checkin) {
    return _checkins.doc(checkin.date).set({
      ...checkin.toMap(),                         // all the check-in fields
      'updatedAt': FieldValue.serverTimestamp(),  // time set by Google's server
    });
  }

  // Live list of the last [days] days, oldest first
  Stream<List<CheckIn>> watchLastDays(int days) {
        final now = DateTime.now();
        final start = DateTime(now.year, now.month, now.day - (days - 1)); // calendar-safe
        return _checkins
        .where('date', isGreaterThanOrEqualTo: CheckIn.dateId(start))
        .orderBy('date')
        .snapshots() // updates automatically when data changes
        .map((snap) => snap.docs.map((d) => CheckIn.fromMap(d.data())).toList());
  }
    // Save many check-ins in ONE trip to Firebase (used by demo data)
  Future<void> saveMany(List<CheckIn> list) async {
    final batch = _db.batch();
    for (final c in list) {
      batch.set(_checkins.doc(c.date), {
        ...c.toMap(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit(); // send everything together
  }

  // Delete ALL of this user's check-ins. Returns how many were deleted.
  Future<int> deleteAll() async {
    final snap = await _checkins.get();
    final docs = snap.docs;
    for (var i = 0; i < docs.length; i += 400) { // groups of 400 (limit is 500)
      final batch = _db.batch();
      for (final d in docs.skip(i).take(400)) {
        batch.delete(d.reference);
      }
      await batch.commit();
    }
    return docs.length;
  }
}