// import 'package:fitness_care/consts/imports.dart';
//
// Widget profileMenuBar({
//   required String title,
//   required IconData icon,
//   required bool endIcon,
//   Color? textColor,
//   Function()? onPress,
// }) {
//   return ListTile(
//     onTap: onPress,
//     leading: Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100), color: lightGray),
//       child: Icon(
//         icon,
//         color: black,
//       ),
//     ),
//     title: title.text.color(textColor ?? black).make(),
//     trailing: endIcon
//         ? Container(
//             width: 30,
//             height: 30,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(100),
//               color: lightGray,
//             ),
//             child: const Icon(
//               Icons.arrow_forward_ios,
//               size: 10,
//             ),
//           )
//         : null,
//   );
// }
//
//



import 'package:fitness_care/consts/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileMenuBar({
  required String title,
  required IconData icon,
  required bool endIcon,
  Color? textColor,
  Function()? onPress,
}) {
  return ListTile(
    onTap: onPress,
    leading: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: lightGray,
      ),
      child: Icon(
        icon,
        color: black,
        size: 24.sp,
      ),
    ),
    title: title.text.color(textColor ?? black).size(16.sp).make(),
    trailing: endIcon
        ? Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: lightGray,
      ),
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    )
        : null,
  );
}
