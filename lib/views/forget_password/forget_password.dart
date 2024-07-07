import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/common%20widgets/custom_text_field.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/views/otp_screen/otp_screen.dart';



class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
          "FORGET PASSWORD ".text.size(30).bold.black.make(),
          const HeightBox(5),
          "Please enter your email to receive \n your password reset code".text.make(),

          const HeightBox(130),
          "Email".text.make(),
          customTextField(
              hint: "Email Address", suffixIcon: FontAwesomeIcons.check),



          const HeightBox(130),
          customButton(
              title: "RESET PASSWORD",
              buttonColor: green,
              padding: (10, 10),
              fontSize: 25,
              font: bebasNeue,
              textColor: Vx.white,
              onPress: () {
                Get.to(const OtpScreen());
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
