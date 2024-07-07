//
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/common%20widgets/custom_text_field.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/views/login_screen/login_screen.dart';
// import 'package:fitness_care/services/auth_service.dart';  // import your AuthService
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   bool loading = false;
//   // controllers for the text fields
//   final _formKey = GlobalKey<FormState>();
//   final fullNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   bool obscurePass = false;
//   // create an instance of AuthService
//
//   final AuthService _authService = AuthService();
//
//   @override
//   void dispose() {
//     fullNameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void signup() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         loading = true;
//       });
//
//       try {
//         await _authService.signup(
//           fullName: fullNameController.text.trim(),
//           phone: phoneController.text.trim(),
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
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Vx.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: true,
//         elevation: 10,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_ios_outlined),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: screenHeight * 0.05),
//               "CREATE ACCOUNT ".text.size(screenWidth * 0.08).bold.black.make(),
//               SizedBox(height: screenHeight * 0.01),
//               "Please enter your credentials to\n proceed".text.make(),
//               SizedBox(height: screenHeight * 0.03),
//               "Full Name".text.make(),
//               customTextField(
//                 controller: fullNameController,
//                 hint: "Your Name",
//                 suffixIcon: FontAwesomeIcons.check,
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               "Phone".text.make(),
//               customTextField(
//                 controller: phoneController,
//                 hint: "Your phone number",
//                 suffixIcon: FontAwesomeIcons.phone,
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               "Email Address".text.make(),
//               customTextField(
//                 controller: emailController,
//                 hint: "Your email address",
//                 suffixIcon: Icons.mail_rounded,
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               "Password".text.make(),
//               customTextField(
//                 controller: passwordController,
//                 hint: "Password",
//                 suffixIcon: obscurePass ? Icons.visibility : Icons.visibility_off,
//                 onPress: () => setState(() => obscurePass = !obscurePass),
//                 obsecure: !obscurePass,
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               customButton(
//                 loading: loading,
//                 title: "CREATE ACCOUNT",
//                 buttonColor: green,
//                 padding: (screenWidth * 0.05, screenHeight * 0.015),
//                 textColor: Vx.white,
//                 onPress: signup,
//               ).box.width(double.maxFinite).make().centered(),
//               SizedBox(height: screenHeight * 0.03),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   "Already have an account?".text.size(screenWidth * 0.038).make(),
//                   TextButton(
//                     onPressed: () {
//                       Get.to(const LoginScreen());
//                     },
//                     child: "Login!".text.black.bold.size(screenWidth * 0.038).make(),
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


import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/common%20widgets/custom_text_field.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:fitness_care/views/login_screen/login_screen.dart';
import 'package:fitness_care/services/auth_service.dart';  // import your AuthService


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  // controllers for the text fields
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePass = false;
  // create an instance of AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await _authService.signup(
          fullName: fullNameController.text.trim(),
          phone: phoneController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
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
              SizedBox(height: 0.01.sh),
              "CREATE ACCOUNT ".text.size(24.sp).bold.black.make(),
              SizedBox(height: 8.h),
              "Please enter your credentials to\n proceed".text.size(14.sp).make(),
              SizedBox(height: 15.h),
              "Full Name".text.size(16.sp).make(),
              customTextField(
                controller: fullNameController,
                hint: "Your Name",
                suffixIcon: FontAwesomeIcons.check,
              ),
              SizedBox(height: 15.h),
              "Phone".text.size(16.sp).make(),
              customTextField(
                controller: phoneController,
                hint: "Your phone number",
                suffixIcon: FontAwesomeIcons.phone,
              ),
              SizedBox(height: 15.h),
              "Email Address".text.size(16.sp).make(),
              customTextField(
                controller: emailController,
                hint: "Your email address",
                suffixIcon: Icons.mail_rounded,
              ),
              SizedBox(height: 15.h),
              "Password".text.size(16.sp).make(),
              customTextField(
                controller: passwordController,
                hint: "Password",
                suffixIcon: obscurePass ? Icons.visibility : Icons.visibility_off,
                onPress: () => setState(() => obscurePass = !obscurePass),
                obsecure: !obscurePass,
              ),
              SizedBox(height: 24.h),
              customButton(
                loading: loading,
                title: "CREATE ACCOUNT",
                buttonColor: green,
                padding: (20.w, 10.h),
                textColor: Vx.white,
                onPress: signup,
              ).box.width(double.maxFinite).make().centered(),
              SizedBox(height: 24.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  "Already have an account?".text.size(14.sp).make(),
                  TextButton(
                    onPressed: () {
                      Get.to(const LoginScreen());
                    },
                    child: "Login!".text.black.bold.size(14.sp).make(),
                  ),
                ],
              ).centered(),
            ],
          ).paddingSymmetric(horizontal: 24.w),
        ),
      ),
    );
  }
}
