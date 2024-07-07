import 'package:fitness_care/consts/imports.dart';
import 'package:pinput/pinput.dart';


Widget otpWidget() {
  final pinTheme = PinTheme(
      width: 56,
      height: 60,

      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
          color: lightGray,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: lightGray)

      )

  );
  return Container(
    child: Pinput(

      length: 4,
        defaultPinTheme: pinTheme,
        focusedPinTheme: pinTheme.copyWith(
          decoration: pinTheme.decoration!.copyWith(
            border: Border.all(
              color: Vx.gray300
            ),
          ),

        ),
        onCompleted: (pin) => debugPrint(pin) ,
    ),

  );



}