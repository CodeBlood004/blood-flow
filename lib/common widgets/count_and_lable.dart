import 'package:fitness_care/consts/imports.dart';


Widget countAndLabel ({
  required int number,
  required String label,
  bool heartBeat = true,

}){

  return Align(
    alignment: Alignment.center,
    child:  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            number.toString().text.size(25).bold.make(),
            const WidthBox(5),
            if(heartBeat == true) "bests/min".text.size(13).make(),
          ],
        ),
        label.text.make()
      ],
    ),

  );


}