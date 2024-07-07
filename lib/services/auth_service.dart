// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fitness_care/common%20widgets/custom_nav_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/views/login_screen/login_screen.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> signup({
//     required String fullName,
//     required String phone,
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       await _firestore.collection('users').doc(email.trim()).set({
//         'fullName': fullName.trim(),
//         'phone': phone.trim(),
//       });
//
//       Utils().toastMessage("Account created successfully!");
//       Get.to(const LoginScreen());
//     } catch (error) {
//       Utils().toastMessage(error.toString());
//     }
//   }
//
//   Future<void> login({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       Utils().toastMessage(userCredential.user!.email.toString());
//       Get.to( CustomNavBar());  // Navigate to home screen after successful login
//     } catch (error) {
//       Utils().toastMessage(error.toString());
//     }
//   }
// }





import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_care/common%20widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:fitness_care/views/login_screen/login_screen.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection('users').doc(email.trim()).set({
        'fullName': fullName.trim(),
        'phone': phone.trim(),
      });

      Utils().toastMessage("Account created successfully!");
      Get.to(const LoginScreen());
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Utils().toastMessage(userCredential.user!.email.toString());
      Get.to(CustomNavBar());  // Navigate to home screen after successful login
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        Utils().toastMessage(userCredential.user!.email.toString());
        Get.to(CustomNavBar());  // Navigate to home screen after successful login
      }
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  Future<void> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        var cred = EmailAuthProvider.credential(email: email, password: oldPassword);
        await currentUser.reauthenticateWithCredential(cred);
        await currentUser.updatePassword(newPassword);
        Utils().toastMessage("Password Changed!");
      }
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.email).delete();
        await user.delete();
        Utils().toastMessage("Account deleted successfully!");
        Get.offAll(const LoginScreen());
      }
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }



}
