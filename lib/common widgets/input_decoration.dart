
import 'package:fitness_care/consts/imports.dart';



InputDecoration inputDecoration({
  required bool enterPrefix,
  IconData? suffixIcon,
  IconData? prefixIcon,
  Function()? onPress,
  String? hintText,
}) {
  return InputDecoration(

    suffixIcon: IconButton(
      icon: Icon(suffixIcon),
      onPressed: onPress,
    ),
    prefixIcon: IconButton(
      icon: Icon(prefixIcon,color: Vx.gray50,),
      onPressed: onPress,
    ),
    // labelText: hintText,
    labelStyle:const TextStyle(color: black) ,
    contentPadding: const EdgeInsets.all(12),
    hintStyle: const TextStyle(color: Vx.gray500),
    errorStyle: const TextStyle(color: Vx.red500),
    hintText: enterPrefix ? "Enter $hintText" : hintText,
    isDense: true,



    fillColor:lightGray ,
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: lightGray),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: lightGray),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),

  );
}
