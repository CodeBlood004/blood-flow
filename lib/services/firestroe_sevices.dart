import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveHeartRate(String heartRate) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email!;
        String checkupId = DateTime.now().millisecondsSinceEpoch.toString();
        String time = DateTime.now().toIso8601String();

        await _firestore.collection('users').doc(email).collection('checkup_list').doc(checkupId).set({
          'time': time,
          'Hr': heartRate,
        });
      }
    } catch (e) {
      print('Failed to save heart rate to Firestore: $e');
    }
  }
}
