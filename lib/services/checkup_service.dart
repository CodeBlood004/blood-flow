import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> fetchCheckupsForDate(DateTime date) async {
    List<Map<String, String>> checkupList = [];
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.email)
            .collection('checkup_list')
            .where('time', isGreaterThanOrEqualTo: "$formattedDate 00:00:00.000")
            .where('time', isLessThan: "$formattedDate 23:59:59.999")
            .get();

        for (var doc in snapshot.docs) {
          checkupList.add({
            'time': doc['time'],
            'Hr': doc['Hr'],
          });
        }
      }
    } catch (e) {
      // Handle error appropriately
    }
    return checkupList;
  }
}
