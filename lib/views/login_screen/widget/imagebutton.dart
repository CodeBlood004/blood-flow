import 'package:fitness_care/consts/imports.dart';

Widget imageButton (

{
  required String image,
}

){

  return Container(
    width: 35,
    height: 35,

    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
        Border.all(color: Color(0xfff6f5f5)),
        color: Color(0xfff6f5f5)
    ),
    child: FloatingActionButton(
      highlightElevation: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {  },
      child: Image(

          width: 35,
          height: 35,
          image: AssetImage(image)
      ),
    ),

  );


}