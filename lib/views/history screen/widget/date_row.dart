// import 'package:fitness_care/consts/imports.dart';
// import 'package:intl/intl.dart';
//
//
//
//
// Widget dateRow({
//    required DateTime dateTime,
//    final Function()? onPressCalender,
//    final Function()? nextMonthPress,
//    final Function()? previousMonthPress,
//
//
//
// }) {
//   return Row(
//     children: [
//       const Image(image: AssetImage(calender), height: 30, width: 30)
//           .onTap(() async =>  onPressCalender?.call() ),
//       const WidthBox(5),
//       "Date".text.make(),
//       const Spacer(),
//
//       IconButton(onPressed: () => previousMonthPress?.call() , icon: const Icon(Icons.arrow_back_ios_outlined)),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           DateFormat('MMMM').format(dateTime).text.make(),
//           " ${dateTime.year}".text.size(15).make(),
//         ],
//       ),
//
//       IconButton(onPressed: () => nextMonthPress?.call(), icon: const Icon(Icons.arrow_forward_ios))
//
//
//     ],
//   );
// }
//
//
//
//
//
//
//
//


import 'package:fitness_care/consts/imports.dart';
import 'package:intl/intl.dart';


Widget dateRow({
  required DateTime dateTime,
  final Function()? onPressCalender,
  final Function()? nextMonthPress,
  final Function()? previousMonthPress,
}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () async => onPressCalender?.call(),
        child: Image.asset(calender, height: 23.h, width: 23.w),
      ),
      SizedBox(width: 5.w),
      "Date".text.size(18.sp).make(),
      const Spacer(),
      IconButton(onPressed: () => previousMonthPress?.call(), icon: Icon(Icons.arrow_back_ios_outlined, size: 17.sp)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DateFormat('MMMM').format(dateTime).text.size(10.sp).make(),
          " ${dateTime.year}".text.size(15.sp).make(),
        ],
      ),
      IconButton(onPressed: () => nextMonthPress?.call(), icon: Icon(Icons.arrow_forward_ios, size: 17.sp)),
    ],
  );
}
