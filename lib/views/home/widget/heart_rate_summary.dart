// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/common%20widgets/count_and_lable.dart';
//
// Widget heartRateSummary({
//   required int currentHR,
//   required double weeklyAvgHR,
//   required int weeklyCheckups,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           countAndLabel(number: currentHR, label: "Current HR"),
//           const SizedBox(
//             height: 60,
//             child: VerticalDivider(thickness: 1, color: textFieldGrey),
//           ),
//           countAndLabel(number: weeklyAvgHR.toInt(), label: "Week Avg"),
//         ],
//       ),
//       const Divider(indent: 60, endIndent: 60, thickness: 1, color: textFieldGrey),
//       countAndLabel(number: weeklyCheckups, label: "Weekly Checkups", heartBeat: false),
//     ],
//   );
// }


import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/common%20widgets/count_and_lable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget heartRateSummary({
  required int currentHR,
  required double weeklyAvgHR,
  required int weeklyCheckups,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          countAndLabel(number: currentHR, label: "Current HR"),
          SizedBox(
            height: 60.h,
            child: VerticalDivider(thickness: 1.w, color: textFieldGrey),
          ),
          countAndLabel(number: weeklyAvgHR.toInt(), label: "Week Avg"),
        ],
      ),
      Divider(indent: 60.w, endIndent: 60.w, thickness: 1.h, color: textFieldGrey),
      countAndLabel(number: weeklyCheckups, label: "Weekly Checkups", heartBeat: false),
    ],
  );
}
