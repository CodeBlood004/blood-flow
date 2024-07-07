//
//
// import 'dart:io';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/services/auth_service.dart';
// import 'package:fitness_care/services/user_service.dart';
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/common%20widgets/custom_text_field.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   bool obscureOldPass = false;
//   bool obscureNewPass = false;
//   bool showPasswordFields = false;
//
//   final UserService _userService = UserService();
//   final AuthService _authService = AuthService();
//
//   File? _image;
//   String? _profileImageUrl;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _oldPassController = TextEditingController();
//   final TextEditingController _newPassController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//     _loadProfileImage();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _oldPassController.dispose();
//     _newPassController.dispose();
//
//     super.dispose();
//   }
//
//   Future<void> _loadProfileImage() async {
//     String imageUrl = await _userService.fetchProfileImageUrl();
//     setState(() {
//       _profileImageUrl = imageUrl;
//     });
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       await _userService.uploadProfileImage(_image!);
//       _loadProfileImage();
//     }
//   }
//
//   void _fetchUserData() async {
//     var userData = await _userService.fetchUserData();
//     setState(() {
//       _nameController.text = userData['fullName'];
//       _phoneController.text = userData['phone'];
//       _emailController.text = userData['email'];
//     });
//   }
//
//   void _updateProfile() async {
//     await _userService.updateUserData(
//       _nameController.text,
//       _phoneController.text,
//     );
//     Utils().toastMessage("Profile updated successfully!");
//   }
//
//   void _changePassword() async {
//     await _authService.changePassword(
//       email: _emailController.text,
//       oldPassword: _oldPassController.text,
//       newPassword: _newPassController.text,
//     );
//   }
//
//   void _confirmDeleteAccount() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Confirm Account Deletion"),
//           content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _authService.deleteAccount(context);
//               },
//               child: const Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.only(top: 40.0),
//             child: Center(
//               child:
//                   "Update profile".text.fontFamily('BebasNeue').size(30).make(),
//             ),
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: true,
//           elevation: 10,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios_outlined),
//           ).paddingOnly(top: 10)),
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
//                           : _profileImageUrl != null &&
//                                   _profileImageUrl!.isNotEmpty
//                               ? Image.network(_profileImageUrl!,
//                                   fit: BoxFit.cover)
//                               : const Image(
//                                   image: AssetImage(emptyProfileImage)),
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
//                             borderRadius: BorderRadius.circular(100),
//                             color: green),
//                         child: const Icon(
//                           LineAwesomeIcons.camera_solid,
//                           color: Vx.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               const Divider(color: Colors.grey, indent: 30, endIndent: 30),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: screenHeight * 0.03),
//                   customTextField(
//                     controller: _nameController,
//                     hint: "Your Name",
//                     suffixIcon: FontAwesomeIcons.check,
//                     enterPrefix: false,
//                   ),
//                   SizedBox(height: screenHeight * 0.03),
//                   customTextField(
//                     controller: _phoneController,
//                     hint: "Your phone number",
//                     suffixIcon: FontAwesomeIcons.phone,
//                     enterPrefix: false,
//                   ),
//                   const SizedBox(height: 20),
//                   const Divider(color: Colors.grey, indent: 30, endIndent: 30),
//                   const SizedBox(height: 10),
//                   "Change Password"
//                       .text
//                       .color(green)
//                       .bold
//                       .size(18)
//                       .make()
//                       .centered()
//                       .onTap(() {
//                     setState(() {
//                       showPasswordFields = !showPasswordFields;
//                     });
//                   }),
//                   const SizedBox(height: 10),
//                   if (showPasswordFields) ...[
//                     customTextField(
//                       hint: "Old Password",
//                       suffixIcon: obscureOldPass
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       onPress: () =>
//                           setState(() => obscureOldPass = !obscureOldPass),
//                       obsecure: !obscureOldPass,
//                       enterPrefix: false,
//                       controller: _oldPassController,
//                     ),
//                     SizedBox(height: screenHeight * 0.03),
//                     customTextField(
//                       hint: "New Password",
//                       suffixIcon: obscureNewPass
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       onPress: () =>
//                           setState(() => obscureNewPass = !obscureNewPass),
//                       obsecure: !obscureNewPass,
//                       enterPrefix: false,
//                       controller: _newPassController,
//                     ),
//                     SizedBox(height: screenHeight * 0.08),
//                     customButton(
//                       title: "Change Password",
//                       buttonColor: Colors.black,
//                       padding: (screenWidth * 0.05, screenHeight * 0.015),
//                       textColor: Vx.white,
//                       onPress: _changePassword,
//                     ).box.width(double.maxFinite).make().centered(),
//                   ],
//                   SizedBox(height: screenHeight * 0.03),
//                   customButton(
//                     title: "Update profile",
//                     buttonColor: green,
//                     padding: (screenWidth * 0.05, screenHeight * 0.015),
//                     textColor: Vx.white,
//                     onPress: _updateProfile,
//                   ).box.width(double.maxFinite).make().centered(),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   "Remove the profile".text.size(screenWidth * 0.038).make(),
//                   TextButton(
//                     onPressed: _confirmDeleteAccount,
//                     child: "Delete"
//                         .text
//                         .red500
//                         .bold
//                         .size(screenWidth * 0.038)
//                         .make(),
//                   ),
//                 ],
//               ).centered(),
//             ],
//           ).paddingSymmetric(horizontal: screenWidth * 0.03),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/services/auth_service.dart';
import 'package:fitness_care/services/user_service.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/common%20widgets/custom_text_field.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool obscureOldPass = false;
  bool obscureNewPass = false;
  bool showPasswordFields = false;

  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  File? _image;
  String? _profileImageUrl;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadProfileImage();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _oldPassController.dispose();
    _newPassController.dispose();

    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    String imageUrl = await _userService.fetchProfileImageUrl();
    setState(() {
      _profileImageUrl = imageUrl;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _userService.uploadProfileImage(_image!);
      _loadProfileImage();
    }
  }

  void _fetchUserData() async {
    var userData = await _userService.fetchUserData();
    setState(() {
      _nameController.text = userData['fullName'];
      _phoneController.text = userData['phone'];
      _emailController.text = userData['email'];
    });
  }

  void _updateProfile() async {
    await _userService.updateUserData(
      _nameController.text,
      _phoneController.text,
    );
    Utils().toastMessage("Profile updated successfully!");
  }

  void _changePassword() async {
    await _authService.changePassword(
      email: _emailController.text,
      oldPassword: _oldPassController.text,
      newPassword: _newPassController.text,
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Account Deletion"),
          content: const Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _authService.deleteAccount(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40.0).r,
            child: Center(
              child: "Update profile"
                  .text
                  .fontFamily('BebasNeue')
                  .size(30.sp)
                  .make(),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ).paddingOnly(top: 10.r)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20).r,
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
                          : _profileImageUrl != null &&
                                  _profileImageUrl!.isNotEmpty
                              ? Image.network(_profileImageUrl!,
                                  fit: BoxFit.cover)
                              : const Image(
                                  image: AssetImage(emptyProfileImage)),
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
                            color: green),
                        child: const Icon(
                          LineAwesomeIcons.camera_solid,
                          color: Vx.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(color: Colors.grey, indent: 30, endIndent: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  customTextField(
                    controller: _nameController,
                    hint: "Your Name",
                    suffixIcon: FontAwesomeIcons.check,
                    enterPrefix: false,
                  ),
                  SizedBox(height: 15.h),
                  customTextField(
                    controller: _phoneController,
                    hint: "Your phone number",
                    suffixIcon: FontAwesomeIcons.phone,
                    enterPrefix: false,
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, indent: 30, endIndent: 30),
                  const SizedBox(height: 10),
                  "Change Password"
                      .text
                      .color(green)
                      .bold.size(15.sp)
                      .make()
                      .centered()
                      .onTap(() {
                    setState(() {
                      showPasswordFields = !showPasswordFields;
                    });
                  }),
                  const SizedBox(height: 10),
                  if (showPasswordFields) ...[
                    customTextField(
                      hint: "Old Password",
                      suffixIcon: obscureOldPass
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onPress: () =>
                          setState(() => obscureOldPass = !obscureOldPass),
                      obsecure: !obscureOldPass,
                      enterPrefix: false,
                      controller: _oldPassController,
                    ),
                    SizedBox(height: 15.h),
                    customTextField(
                      hint: "New Password",
                      suffixIcon: obscureNewPass
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onPress: () =>
                          setState(() => obscureNewPass = !obscureNewPass),
                      obsecure: !obscureNewPass,
                      enterPrefix: false,
                      controller: _newPassController,
                    ),
                    SizedBox(height: 50.h),
                    customButton(
                      title: "Change Password",
                      buttonColor: Colors.black,
                      padding: (0.w, 12.h, ),
                      textColor: Vx.white,
                      onPress: _changePassword,
                    ).box.width(double.maxFinite).make().centered(),
                  ],
                  SizedBox(height: 15.h),
                  customButton(
                    title: "Update profile",
                    buttonColor: green,
                    font: bebasNeue,
                    fontSize: 20.sp,
                    padding: (0.w, 7.h, ),
                    textColor: Vx.white,
                    onPress: _updateProfile,
                  ).box.width(double.maxFinite).make().centered(),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  "Remove the profile".text.size(14.sp).make(),
                  TextButton(
                    onPressed: _confirmDeleteAccount,
                    child: "Delete".text.red500.bold.size(14.sp).make(),
                  ),
                ],
              ).centered(),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}
