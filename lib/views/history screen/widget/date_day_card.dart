// import 'package:fitness_care/consts/imports.dart';
// import 'package:intl/intl.dart';
//
//
//
// Widget dateDayCard ({
//     required String dayName,
//     required String date,
//
//
// }){
//   Color? bgColor = lightGray ;
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//
//       // DateFormat("EEE").format(dateTime).text.black.make(),
//       dayName.text.black.make(),
//       5.heightBox,
//       CircleAvatar(
//         backgroundColor: Vx.white,
//         child: date.text.black.make(),
//       )
//
//
//     ],
//   ).box.roundedSM.width(60).color(bgColor).make().onTap(() {
//
//     // toggle the bgColor between lightgray and black
//     bgColor = (bgColor == lightGray) ? Colors.black : lightGray;
//   });
//
//
// }



import 'package:fitness_care/consts/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dateDayCard({
  required String dayName,
  required String date,
}) {
  Color? bgColor = lightGray;

  return GestureDetector(
    onTap: () {
      // Toggle the bgColor between lightgray and black
      bgColor = (bgColor == lightGray) ? Colors.black : lightGray;
    },
    child: Container(

      width: 60.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dayName.text.black.size(14.sp).make(),
          SizedBox(height: 5.h),
          CircleAvatar(
            backgroundColor: Vx.white,
            child: date.text.black.size(12.sp).make(),
          ),
        ],
      ),
    ),
  );
}



// import 'package:fitness_care/consts/imports.dart';
//
// Widget dateDayCard({
//   required String dayName,
//   required String date,
//
// }) {
//
//
//   return Obx(() => Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       dayName.text.black.make(),
//       const SizedBox(height: 5),
//       CircleAvatar(
//         backgroundColor: Vx.white,
//         child: date.text.black.make(),
//       ),
//     ],
//   ).box.roundedSM.width(60).height(80).color(bgColor.value).make().onTap(() {
//     // Toggle the bgColor between lightgray and black
//     bgColor.value = (bgColor.value == lightGray) ? Colors.black : lightGray;
//   }));
// }
