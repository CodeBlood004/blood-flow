import 'package:fitness_care/common%20widgets/bg.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/views/login_screen/login_screen.dart';


class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: bgWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 0.6.sh, // 60% of the screen height
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "DERMA".text.color(green).fontFamily(bebasNeue).size(45.sp).bold.make(),
                          const SizedBox(width: 5), // Replaced WidthBox with SizedBox
                          "-H".text.black.size(45.sp).bold.make()
                        ]),
                    SizedBox(height: 80.h), // Replaced HeightBox with SizedBox

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Lets Start the journey with ".text.size(18.sp).semiBold.black.make(),
                        "DERMA".text.bold.color(green).size(18.sp).make(),
                        "-H".text.bold.black.size(18.sp).make()
                      ],
                    ),
                    " your personal health tracker ".text.size(18.sp).semiBold.black.make(),

                    SizedBox(height: 100.h), // Replaced HeightBox with SizedBox
                    customButton(
                        title: "GET STARTED",
                        textColor: black,
                        buttonColor: green,
                        onPress: () {
                          Get.to(const LoginScreen());
                        },
                        padding: ( 50, 10.h) // Adjusted padding
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
