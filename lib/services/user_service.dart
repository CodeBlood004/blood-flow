import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:path/path.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> fetchUserName() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.email).get();
        return userDoc['fullName'];
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return "Loading...";
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.email).get();
        return {
          'fullName': userDoc['fullName'],
          'phone': userDoc['phone'],
          'email': user.email,
        };
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return {
      'fullName': '',
      'phone': '',
      'email': '',
    };
  }

  Future<void> updateUserData(String fullName, String phone) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.email).update({
          'fullName': fullName,
          'phone': phone,
        });
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchCheckupData() async {
    int currentHR = 0;
    double weeklyAvgHR = 0;
    int weeklyCheckups = 0;

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
        QuerySnapshot checkupsSnapshot = await _firestore
            .collection('users')
            .doc(user.email)
            .collection('checkup_list')
            .where('time', isGreaterThanOrEqualTo: oneWeekAgo.toIso8601String())
            .get();

        if (checkupsSnapshot.docs.isNotEmpty) {
          List<int> heartRates = [];
          checkupsSnapshot.docs.forEach((doc) {
            heartRates.add(int.parse(doc['Hr']));
          });

          currentHR = heartRates.last;
          weeklyAvgHR = heartRates.reduce((a, b) => a + b) / heartRates.length;
          weeklyCheckups = heartRates.length;
        }
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }

    return {
      'currentHR': currentHR,
      'weeklyAvgHR': weeklyAvgHR,
      'weeklyCheckups': weeklyCheckups,
    };
  }

  Future<String> fetchProfileImageUrl() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.email).get();
        return userDoc['profileImageUrl'];
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return "";
  }

  Future<void> uploadProfileImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String fileName = basename(image.path);
        Reference storageRef =
            _storage.ref().child('profile_images/${user.uid}/$fileName');
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _firestore
            .collection('users')
            .doc(user.email)
            .update({'profileImageUrl': downloadUrl});
        Utils().toastMessage("Profile image uploaded successfully!");
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}
