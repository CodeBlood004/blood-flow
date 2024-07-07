//
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/views/profile_page/edit_profile.dart';
// import 'package:fitness_care/views/profile_page/widget/profile_menu.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/services/user_service.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   File? _image;
//   String? _profileImageUrl;
//   String? _fullName;
//   String? _email;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//   }
//
//   Future<void> _loadProfileData() async {
//     UserService userService = UserService();
//     String imageUrl = await userService.fetchProfileImageUrl();
//     var userData = await userService.fetchUserData();
//
//     setState(() {
//       _profileImageUrl = imageUrl;
//       _fullName = userData['fullName'];
//       _email = userData['email'];
//     });
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//
//       await _uploadImageToFirebase(_image!);
//     }
//   }
//
//   Future<void> _uploadImageToFirebase(File image) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         String fileName = basename(image.path);
//         Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}/$fileName');
//         UploadTask uploadTask = storageRef.putFile(image);
//
//         TaskSnapshot snapshot = await uploadTask;
//         String downloadUrl = await snapshot.ref.getDownloadURL();
//
//         await FirebaseFirestore.instance.collection('users').doc(user.email).update({'profileImageUrl': downloadUrl});
//         setState(() {
//           _profileImageUrl = downloadUrl;
//         });
//
//         Utils().toastMessage("Profile image uploaded successfully!");
//       }
//     } catch (e) {
//       Utils().toastMessage(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Padding(
//           padding: const EdgeInsets.only(top: 40.0),
//           child: Center(
//             child: "PROFILE"
//                 .text
//                 .fontFamily(bebasNeue)
//                 .size(30)
//                 .make(),
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         elevation: 10,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     height: 150,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: _image != null
//                           ? Image.file(_image!, fit: BoxFit.cover)
//                           : _profileImageUrl != null && _profileImageUrl!.isNotEmpty
//                           ? Image.network(_profileImageUrl!, fit: BoxFit.cover)
//                           : const Image(image: AssetImage(emptyProfileImage)),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: green,
//                         ),
//                         child: const Icon(LineAwesomeIcons.pencil_alt_solid, color: Vx.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               _fullName != null
//                   ? _fullName!.text.size(25).fontFamily(bebasNeue).black.make()
//                   : CircularProgressIndicator(),
//               _email != null
//                   ? _email!.text.make()
//                   : CircularProgressIndicator(),
//               const HeightBox(30),
//               customButton(
//                 title: "Edit Profile",
//                 fontSize: 18,
//                 padding: (40, 10),
//                 buttonColor: green,
//                 textColor: Vx.white,
//                 onPress: () {
//                   Get.to(const EditProfile());
//                 },
//               ),
//               const HeightBox(30),
//               const Divider(color: Vx.white, indent: 30, endIndent: 30, thickness: 0),
//               const HeightBox(30),
//               Column(
//                 children: [
//                   profileMenuBar(title: "Settings", icon: LineAwesomeIcons.cog_solid, endIcon: true),
//                   profileMenuBar(title: "User Management", icon: LineAwesomeIcons.user_check_solid, endIcon: true),
//                   const Divider(color: textFieldGrey, indent: 30, endIndent: 30),
//                   profileMenuBar(title: "information", icon: LineAwesomeIcons.info_solid, endIcon: true),
//                   profileMenuBar(title: "Logout", icon: LineAwesomeIcons.sign_out_alt_solid, endIcon: false, textColor: Colors.red),
//                 ],
//               ).paddingAll(20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//




import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/views/profile_page/edit_profile.dart';
import 'package:fitness_care/views/profile_page/widget/profile_menu.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:fitness_care/services/user_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String? _profileImageUrl;
  String? _fullName;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    UserService userService = UserService();
    String imageUrl = await userService.fetchProfileImageUrl();
    var userData = await userService.fetchUserData();

    setState(() {
      _profileImageUrl = imageUrl;
      _fullName = userData['fullName'];
      _email = userData['email'];
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await _uploadImageToFirebase(_image!);
    }
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String fileName = basename(image.path);
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}/$fileName');
        UploadTask uploadTask = storageRef.putFile(image);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(user.email).update({'profileImageUrl': downloadUrl});
        setState(() {
          _profileImageUrl = downloadUrl;
        });

        Utils().toastMessage("Profile image uploaded successfully!");
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Center(
            child: "PROFILE"
                .text
                .fontFamily(bebasNeue)
                .size(30.sp)
                .make(),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 130.w,
                    height: 130.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                          ? Image.network(_profileImageUrl!, fit: BoxFit.cover)
                          : const Image(image: AssetImage(emptyProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: green,
                        ),
                        child: const Icon(LineAwesomeIcons.pencil_alt_solid, color: Vx.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _fullName != null
                  ? _fullName!.text.size(25.sp).fontFamily(bebasNeue).black.make()
                  : "Loading...".text.bold.make(),
              _email != null
                  ? _email!.text.make()
                  : "...".text.make(),
              SizedBox(height: 30.h),
              customButton(
                title: "Edit Profile",
                fontSize: 18.sp,
                padding: ( 20.h, 10.w),
                buttonColor: green,
                textColor: Vx.white,
                onPress: () {
                  Get.to(const EditProfile());
                },
              ),
              SizedBox(height: 5.h),
              const Divider(color: Vx.white, indent: 30, endIndent: 30, thickness: 0),
              SizedBox(height: 5.h),
              Column(
                children: [
                  profileMenuBar(title: "Settings", icon: LineAwesomeIcons.cog_solid, endIcon: true),
                  profileMenuBar(title: "User Management", icon: LineAwesomeIcons.user_check_solid, endIcon: true),
                  const Divider(color: textFieldGrey, indent: 30, endIndent: 30),
                  profileMenuBar(title: "Information", icon: LineAwesomeIcons.info_solid, endIcon: true),
                  profileMenuBar(title: "Logout", icon: LineAwesomeIcons.sign_out_alt_solid, endIcon: false, textColor: Colors.red),
                ],
              ).paddingAll(20.w),
            ],
          ),
        ),
      ),
    );
  }
}
