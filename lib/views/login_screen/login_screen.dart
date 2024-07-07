// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/common%20widgets/custom_nav_bar.dart';
// import 'package:fitness_care/common%20widgets/custom_text_field.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/views/forget_password/forget_password.dart';
// import 'package:fitness_care/views/signup_screen/signup_screen.dart';
// import 'package:flutter/services.dart';
//
//
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool obscurePass = false;
//   bool loading = false;
//
//   // controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   final _auth = FirebaseAuth.instance;
//
//   void login() {
//     setState(() {
//       loading = true;
//     });
//     _auth
//         .signInWithEmailAndPassword(
//             email: emailController.text.toString(),
//             password: passwordController.text.toString())
//         .then((value) {
//       Utils().toastMessage(value.user!.email.toString());
//       setState(() {
//         loading = false;
//       });
//       Get.to(CustomNavBar());
//     }).onError((error, stackTrace) {
//       Utils().toastMessage(error.toString());
//       setState(() {
//         loading = false;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Vx.white,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: true,
//           elevation: 10,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios_outlined),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               "WELCOME TO OUR APP ".text.size(30).bold.black.make(),
//               const HeightBox(5),
//               "Hello there, sign in to \n continue!".text.make(),
//               const HeightBox(30),
//               "Email Address".text.make(),
//               customTextField(
//                 controller: emailController,
//                 hint: "Email Address",
//                 suffixIcon: FontAwesomeIcons.check,
//               ),
//               const HeightBox(5),
//               "Password".text.make(),
//               customTextField(
//                 controller: passwordController,
//                 hint: "Password",
//                 suffixIcon:
//                     obscurePass ? Icons.visibility : Icons.visibility_off,
//                 onPress: () => setState(() => obscurePass = !obscurePass),
//                 obsecure: !obscurePass,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Get.to(const ForgetPassword());
//                   },
//                   child: "Forget Password"
//                       .text
//                       .color(textFieldGrey)
//                       .size(18)
//                       .make(),
//                 ),
//               ),
//               const HeightBox(15),
//               customButton(
//                 loading: loading,
//                 title: "LOGIN",
//                 buttonColor: green,
//                 padding: (10, 10),
//                 fontSize: 25,
//                 font: bebasNeue,
//                 textColor: Vx.white,
//                 onPress: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//
//                   }
//                 },
//               ).box.width(double.maxFinite).make().centered(),
//               const HeightBox(20),
//               "or login in with"
//                   .text
//                   .size(18)
//                   .color(Colors.grey)
//                   .make()
//                   .centered(),
//               const HeightBox(40),
//               customButton(
//                 title: "Connect with Google",
//                 buttonColor: lightGray,
//                 textColor: Vx.black,
//                 prefixLogo: googleLogo,
//                 padding: (10, 15),
//                 onPress: () {},
//               ).box.width(double.maxFinite).make(),
//               const HeightBox(150),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   "Don't have an account?".text.size(15).make(),
//                   TextButton(
//                     onPressed: () {
//                       Get.to(const SignupScreen());
//                     },
//                     child: "Register Now".text.black.bold.size(15).make(),
//                   ),
//                 ],
//               ).centered(),
//             ]).px12(),
//           ),
//         ),
//       ),
//     );
//   }
// }





//
//
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/common%20widgets/custom_text_field.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/views/forget_password/forget_password.dart';
// import 'package:fitness_care/views/signup_screen/signup_screen.dart';
// import 'package:flutter/services.dart';
// import 'package:fitness_care/services/auth_service.dart';  // import your AuthService
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool obscurePass = false;
//   bool loading = false;
//
//   // controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   // create an instance of AuthService
//   final AuthService _authService = AuthService();
//
//   void login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         loading = true;
//       });
//
//       try {
//         await _authService.login(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim(),
//           context: context,
//         );
//       } catch (error) {
//         Utils().toastMessage(error.toString());
//       } finally {
//         setState(() {
//           loading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Vx.white,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: true,
//           elevation: 10,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios_outlined),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 "WELCOME TO OUR APP ".text.size(30).bold.black.make(),
//                 const HeightBox(5),
//                 "Hello there, sign in to \n continue!".text.make(),
//                 const HeightBox(30),
//                 "Email Address".text.make(),
//                 customTextField(
//                   controller: emailController,
//                   hint: "Email Address",
//                   suffixIcon: FontAwesomeIcons.check,
//                 ),
//                 const HeightBox(5),
//                 "Password".text.make(),
//                 customTextField(
//                   controller: passwordController,
//                   hint: "Password",
//                   suffixIcon:
//                   obscurePass ? Icons.visibility : Icons.visibility_off,
//                   onPress: () => setState(() => obscurePass = !obscurePass),
//                   obsecure: !obscurePass,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Get.to(const ForgetPassword());
//                     },
//                     child: "Forget Password"
//                         .text
//                         .color(textFieldGrey)
//                         .size(18)
//                         .make(),
//                   ),
//                 ),
//                 const HeightBox(15),
//                 customButton(
//                   loading: loading,
//                   title: "LOGIN",
//                   buttonColor: green,
//                   padding: (10, 10),
//                   fontSize: 25,
//                   font: bebasNeue,
//                   textColor: Vx.white,
//                   onPress: login,
//                 ).box.width(double.maxFinite).make().centered(),
//                 const HeightBox(20),
//                 "or login in with"
//                     .text
//                     .size(18)
//                     .color(Colors.grey)
//                     .make()
//                     .centered(),
//                 const HeightBox(40),
//                 customButton(
//                   title: "Connect with Google",
//                   buttonColor: lightGray,
//                   textColor: Vx.black,
//                   prefixLogo: googleLogo,
//                   padding: (10, 15),
//                   onPress: () {},
//                 ).box.width(double.maxFinite).make(),
//                 const HeightBox(150),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     "Don't have an account?".text.size(15).make(),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(const SignupScreen());
//                       },
//                       child: "Register Now".text.black.bold.size(15).make(),
//                     ),
//                   ],
//                 ).centered(),
//               ],
//             ).px12(),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/common%20widgets/custom_text_field.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:fitness_care/views/forget_password/forget_password.dart';
import 'package:fitness_care/views/signup_screen/signup_screen.dart';
import 'package:flutter/services.dart';
import 'package:fitness_care/services/auth_service.dart';  // import your AuthService
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePass = false;
  bool loading = false;
  bool loadingGoogle = false;

  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // create an instance of AuthService
  final AuthService _authService = AuthService();

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await _authService.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
      } catch (error) {
        Utils().toastMessage(error.toString());
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void signInWithGoogle() async {
    setState(() {
      loadingGoogle = true;
    });

    try {
      await _authService.signInWithGoogle();
    } catch (error) {
      Utils().toastMessage(error.toString());
    } finally {
      setState(() {
        loadingGoogle = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Vx.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "WELCOME TO OUR APP ".text.size(24.sp).bold.black.make(),
                SizedBox(height: 5.h),
                "Hello there, sign in to \n continue!".text.size(14.sp).make(),
                SizedBox(height: 30.h),
                "Email Address".text.size(16.sp).make(),
                customTextField(
                  controller: emailController,
                  hint: "Email Address",
                  suffixIcon: FontAwesomeIcons.check,
                ),
                SizedBox(height: 5.h),
                "Password".text.size(16.sp).make(),
                customTextField(
                  controller: passwordController,
                  hint: "Password",
                  suffixIcon: obscurePass ? Icons.visibility : Icons.visibility_off,
                  onPress: () => setState(() => obscurePass = !obscurePass),
                  obsecure: !obscurePass,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(const ForgetPassword());
                    },
                    child: "Forget Password".text.color(textFieldGrey).size(14.sp).make(),
                  ),
                ),
                SizedBox(height: 15.h),
                customButton(
                  loading: loading,
                  title: "LOGIN",
                  buttonColor: green,
                  padding: (10.w, 10.h),
                  fontSize: 18.sp,
                  font: bebasNeue,
                  textColor: Vx.white,
                  onPress: login,
                ).box.width(double.maxFinite).make().centered(),
                SizedBox(height: 20.h),
                "or login in with".text.size(14.sp).color(Colors.grey).make().centered(),
                SizedBox(height: 40.h),
                customButton(
                  loading: loadingGoogle,
                  title: "Connect with Google",
                  buttonColor: lightGray,
                  textColor: Vx.black,
                  prefixLogo: googleLogo,
                  padding: (10.w, 10.h),
                  onPress: signInWithGoogle,
                ).box.width(double.maxFinite).make(),
                SizedBox(height: 100.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    "Don't have an account?".text.size(14.sp).make(),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: "Register Now".text.color(green).bold.size(14.sp).make(),
                    ),
                  ],
                ).centered(),
              ],
            ).paddingSymmetric(horizontal: 24.w),
          ),
        ),
      ),
    );
  }
}
