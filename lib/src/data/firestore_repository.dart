import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker_app_flutter_firebase/src/data/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addJob(String uid, String title, String company) =>
      _firestore.collection('jobs').add({
        'uid': uid,
        'title': title,
        'company': company,
      });

  /// doc('jobs/$jobId') same with collection('jobs').doc(jobId)
  Future<void> updateJob(
          String uid, String jobId, String title, String company) =>
      _firestore.doc('jobs/$jobId').update({
        'uid': uid,
        'title': title,
        'company': company,
      });

  /// doc('jobs/$jobId') same with collection('jobs').doc(jobId)
  Future<void> deleteJob(String uid, String jobId) =>
      _firestore.collection('jobs').doc(jobId).delete();

  Query<Job> jobsQuery() {
    return _firestore.collection('jobs').withConverter(
          fromFirestore: (snapshot, _) => Job.fromMap(snapshot.data()!),
          toFirestore: (job, options) => job.toMap(),
        );
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
