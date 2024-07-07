import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/common%20widgets/custom_dialog.dart';
import 'package:fitness_care/common%20widgets/custom_text_field.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/consts/strings.dart';
import 'package:fitness_care/views/otp_screen/otp_screen.dart';


class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  // final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  bool obscurePass = false;
  bool obscureConfPass = false;





@override
  void dispose() {

  _passwordController.dispose();
  _repasswordController.dispose();
  super.dispose();
  }
  void showError({required String message, required String title}) =>
      errorDialogue(
        context: context,
        message: message,
        title: title,
      );


  void validateUser() async {

      if (_passwordController.text.length < 6) {
        showError(
          message: passLengthValid,
          title: poorPass,
        );
        return;
      }
      if (_passwordController.text != _repasswordController.text) {
        showError(
          message: passNotMatch,
          title: confirmPass,
        );
        return;
      }

    // VxToast.show(context, msg: "password reset successfully",showTime: 3000,bgColor: Vx.black,textColor: Vx.white);


  }



  @override
  Widget build(BuildContext context) {
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
          )),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          "RESET PASSWORD ".text.size(30).bold.black.make(),
          const HeightBox(5),
          "Reset your password by entering your new password below "
              .text
              .make(),
          const HeightBox(30),
          "Password ".text.make(),
          customTextField(
              hint: "Your new password",
              suffixIcon: obscurePass? Icons.visibility : Icons.visibility_off,
              obsecure: !obscurePass,
              controller: _passwordController,
              onPress: () => setState(()=>obscurePass = !obscurePass)),
          const HeightBox(5),
          "Confirm Password ".text.make(),
          customTextField(
              hint: "Your password again ",
              suffixIcon: obscureConfPass ? Icons.visibility : Icons.visibility_off,
              obsecure: !obscureConfPass,
              controller: _repasswordController,
              onPress: () => setState(()=>obscureConfPass = !obscureConfPass)

          ),
          const HeightBox(50),
          customButton(

                  title: "Reset Password",
                  buttonColor: green,
                  padding: (10, 10),
                  fontSize: 25,
                  font: bebasNeue,
                  textColor: Vx.white,
                  onPress: (){


                      validateUser();


                      // if (_passwordController.text.length >= 6 &&
                      //     _passwordController.text == _repasswordController.text) {
                      //   Get.to(const OtpScreen());
                      // }


                  }
                    )
                    .box
                    .width(double.maxFinite
                  )
              .make()
              .centered(),
        ]).px12(),
      ),
    );
  }
}
