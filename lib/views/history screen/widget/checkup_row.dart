import 'package:fitness_care/consts/imports.dart';


Widget checkupRow({
  String? time,
  String? bpm,
}) {
  return Row(
    children: [
      Icon(FontAwesomeIcons.heartPulse, size: 24.sp),
      SizedBox(width: 5.w),
      (time ?? "05:44 AM").text.size(16.sp).make(),
      const Spacer(),
      (bpm ?? "22 bpm").text.size(16.sp).make(),
    ],
  ).box.height(40.h).make().paddingSymmetric(horizontal: 8.w);
}

// import 'package:fitness_care/consts/imports.dart';
//
// Widget checkupRow({
//   required String? time,
//   required String? bpm,
// }) {
//   return Row(
//     children: [
//       const Icon(FontAwesomeIcons.heartPulse),
//       const WidthBox(5),
//       (time != null ? time : "Unknown time").text.make(),
//       const Spacer(),
//       (bpm != null ? "$bpm bpm" : "Unknown bpm").text.make(),
//     ],
//   ).box.height(40).make();
// }