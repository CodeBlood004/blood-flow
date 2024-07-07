import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/consts/strings.dart';
import 'package:fitness_care/views/otp_screen/widget/OTP_textbox.dart';
import 'package:fitness_care/views/reset_password/reset_password_screen.dart';



class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String userEmail = 'abdullah10004d@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 10,

          leading: IconButton(
            onPressed: (){
              Get.back();

            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          )
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          "VERIFY ACCOUNT ".text.size(30).bold.black.make(),
          const HeightBox(5),
          // "Verify you account by entering verification \n code we sent you $userEmail" .text.make(),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
             const   TextSpan(
                  text: "Verify your account by entering the verification code we sent you on ",
               style: TextStyle(
                 fontSize: 20,
                 color: Vx.black,
                  fontWeight: FontWeight.normal,
                   decoration: TextDecoration.none,
                   fontFamily: regular

               )
                ),
                TextSpan(
                  text: userEmail,
                  style: const TextStyle(color: green,
                    fontSize: 20,
                      decoration: TextDecoration.none,
                    fontFamily: regular

                  ), // Make email green
                ),
              ],
            ),
          ),

          const HeightBox(40),

          otpWidget().centered(),
          

          const HeightBox(5),
          TextButton(
              onPressed: () {},
              child: resendCode.text.black.bold.size(15).make()).centered(),


          const HeightBox(130),
          customButton(
              title: "VERIFY",
              buttonColor: green,
              padding: (10, 10),
              fontSize: 25,
              font: bebasNeue,
              textColor: Vx.white,
              onPress: () {
                Get.to(const RestPasswordScreen());
                VxToast.show(context, msg: "Otp matched successfully", showTime: 3000,bgColor: Vx.black,textColor: Vx.white);
              })
              .box
              .width(double.maxFinite)
              .make()
              .centered(),



        ]).px12(),
      ),
    );
  }
}
