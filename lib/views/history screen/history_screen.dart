// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/model/date_day.dart';
// import 'package:fitness_care/views/history%20screen/widget/checkup_row.dart';
// import 'package:fitness_care/views/history%20screen/widget/date_day_card.dart';
// import 'package:fitness_care/views/history%20screen/widget/date_row.dart';
// import 'package:intl/intl.dart';
//
//
// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   Rx<DateTime> datePicked = DateTime.now().obs;
//
//   void calenderFunc() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2022),
//         lastDate: DateTime(2025));
//     if (pickedDate != null) {
//       datePicked.value = pickedDate;
//     }
//   }
//
//   void nextMonth() {
//     int newMonth = datePicked.value.month + 1;
//     int newYear = datePicked.value.year;
//     if (newMonth > 12) {
//       newMonth = 1;
//       newYear++;
//     }
//     datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
//   }
//
//   void previousMonth() {
//     int newMonth = datePicked.value.month - 1;
//     int newYear = datePicked.value.year;
//
//     if (newMonth < 1) {
//       newMonth = 12;
//       newYear--;
//     }
//     datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
//   }
//
//   List<DateDay> getDaysOfMonth(DateTime datePicked) {
//     List<DateDay> daysOfMonth = [];
//
//     // Get the first day of the month
//     DateTime firstDayOfMonth = DateTime(datePicked.year, datePicked.month, 1);
//
//     // Get the number of days in the month
//     int daysInMonth = DateTime(datePicked.year, datePicked.month + 1, 0).day;
//
//     // Iterate through each day of the month
//     for (int i = 0; i < daysInMonth; i++) {
//       // Calculate the date for the current day
//       DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
//
//       // Add the day and date to the list
//       daysOfMonth.add(
//         DateDay(
//           DateFormat('EEE').format(currentDate),
//           currentDate.day.toString(),
//         ),
//       );
//     }
//
//     return daysOfMonth;
//   }
//
//   List<Widget> dateDayCardlist() {
//     List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);
//
//     return daysOfMonth.map((item) {
//       return dateDayCard(dayName: item.day, date: item.date);
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Vx.white,
//       appBar: AppBar(
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.only(top: 40.0),
//             child: Center(
//               child: "HISTORY".text.fontFamily(bebasNeue).size(30).make(),
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: false,
//           elevation: 10,
//           ),
//       body: SingleChildScrollView(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const HeightBox(30),
//
//           Obx(
//             () => dateRow(
//                 dateTime: datePicked.value,
//                 onPressCalender: calenderFunc,
//                 nextMonthPress: nextMonth,
//                 previousMonthPress: previousMonth),
//           ),
//
//           const HeightBox(20),
//           SizedBox(
//             // width: double.maxFinite,
//             height: 100,
//             width: context.screenWidth - 50,
//             // color: Colors.green,
//             child: Obx(
//               () => VxSwiper.builder(
//                 itemCount: dateDayCardlist().length,
//                 aspectRatio: 5,
//                 viewportFraction: 0.25, // Show 4 items at once
//                 itemBuilder: (context, index) => dateDayCardlist()[index],
//               ),
//             ),
//           ).paddingOnly(left: 30, right: 30),
//
//           SizedBox(
//             width: double.maxFinite,
//             height: 300,
//             // color: Colors.blue,
//
//             child: ListView(
//               children: [
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//                 checkupRow(),
//               ],
//             ),
//           ).paddingAll(50),
//
//           // const HeightBox(50),
//           customButton(
//               title: "Delete",
//               buttonColor: green,
//               padding: (10, 10),
//               fontSize: 25,
//               font: bebasNeue,
//               textColor: Vx.white,
//               onPress: () {
//                 List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);
//                 // printDaysOfMonth(daysOfMonth);
//               }).box.width(double.maxFinite).make().centered(),
//         ]).px12(),
//       ),
//     );
//   }
// }




import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/model/date_day.dart';
import 'package:fitness_care/views/history%20screen/widget/checkup_row.dart';
import 'package:fitness_care/views/history%20screen/widget/date_day_card.dart';
import 'package:fitness_care/views/history%20screen/widget/date_row.dart';
import 'package:intl/intl.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Rx<DateTime> datePicked = DateTime.now().obs;

  void calenderFunc() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));
    if (pickedDate != null) {
      datePicked.value = pickedDate;
    }
  }

  void nextMonth() {
    int newMonth = datePicked.value.month + 1;
    int newYear = datePicked.value.year;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }
    datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
  }

  void previousMonth() {
    int newMonth = datePicked.value.month - 1;
    int newYear = datePicked.value.year;

    if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }
    datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
  }

  List<DateDay> getDaysOfMonth(DateTime datePicked) {
    List<DateDay> daysOfMonth = [];

    // Get the first day of the month
    DateTime firstDayOfMonth = DateTime(datePicked.year, datePicked.month, 1);

    // Get the number of days in the month
    int daysInMonth = DateTime(datePicked.year, datePicked.month + 1, 0).day;

    // Iterate through each day of the month
    for (int i = 0; i < daysInMonth; i++) {
      // Calculate the date for the current day
      DateTime currentDate = firstDayOfMonth.add(Duration(days: i));

      // Add the day and date to the list
      daysOfMonth.add(
        DateDay(
          DateFormat('EEE').format(currentDate),
          currentDate.day.toString(),
        ),
      );
    }

    return daysOfMonth;
  }

  List<Widget> dateDayCardlist() {
    List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);

    return daysOfMonth.map((item) {
      return dateDayCard(dayName: item.day, date: item.date);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Center(
            child: "HISTORY".text.fontFamily(bebasNeue).size(30.sp).make(),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15.h),
          Obx(
                () => dateRow(
                dateTime: datePicked.value,
                onPressCalender: calenderFunc,
                nextMonthPress: nextMonth,
                previousMonthPress: previousMonth),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 100.h,
            width: context.screenWidth - 50.w,
            child: Obx(
                  () => VxSwiper.builder(
                itemCount: dateDayCardlist().length,
                aspectRatio: 5,
                viewportFraction: 0.25,
                itemBuilder: (context, index) => dateDayCardlist()[index],
              ),
            ),
          ).paddingSymmetric(horizontal: 25.w),
          SizedBox(
            width: double.maxFinite,
            height: 350.h,
            child: ListView(
              children: List.generate(18, (index) => checkupRow()),
            ),
          ).paddingAll(30.w),
          const HeightBox(20),
          customButton(
            title: "Delete",
            buttonColor: green,
            padding: ( 0,  7.h),
            fontSize: 20.sp,
            font: bebasNeue,
            textColor: Vx.white,
            onPress: () {
              List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);
            },
          ).box.width(double.maxFinite).make().centered(),
        ]).paddingSymmetric(horizontal: 24.w),
      ),
    );
  }
}






















// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/model/date_day.dart';
// import 'package:fitness_care/views/history%20screen/widget/checkup_row.dart';
// import 'package:fitness_care/views/history%20screen/widget/date_day_card.dart';
// import 'package:fitness_care/views/history%20screen/widget/date_row.dart';
// import 'package:fitness_care/views/home/home_screen.dart';
// import 'package:intl/intl.dart';
// import 'package:fitness_care/services/checkup_service.dart'; // import CheckupService
//
// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   Rx<DateTime> datePicked = DateTime.now().obs;
//   final CheckupService _checkupService = CheckupService();
//   RxList<Map<String, String>> checkupList = <Map<String, String>>[].obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCheckupsForSelectedDate();
//     ever(datePicked, (_) => _fetchCheckupsForSelectedDate());
//   }
//
//   void calenderFunc() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2022),
//         lastDate: DateTime(2025));
//     if (pickedDate != null) {
//       datePicked.value = pickedDate;
//     }
//   }
//
//   void nextMonth() {
//     int newMonth = datePicked.value.month + 1;
//     int newYear = datePicked.value.year;
//     if (newMonth > 12) {
//       newMonth = 1;
//       newYear++;
//     }
//     datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
//   }
//
//   void previousMonth() {
//     int newMonth = datePicked.value.month - 1;
//     int newYear = datePicked.value.year;
//
//     if (newMonth < 1) {
//       newMonth = 12;
//       newYear--;
//     }
//     datePicked.value = DateTime(newYear, newMonth, datePicked.value.day);
//   }
//
//   List<DateDay> getDaysOfMonth(DateTime datePicked) {
//     List<DateDay> daysOfMonth = [];
//
//     DateTime firstDayOfMonth = DateTime(datePicked.year, datePicked.month, 1);
//     int daysInMonth = DateTime(datePicked.year, datePicked.month + 1, 0).day;
//
//     for (int i = 0; i < daysInMonth; i++) {
//       DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
//       daysOfMonth.add(DateDay(DateFormat('EEE').format(currentDate), currentDate.day.toString()));
//     }
//
//     return daysOfMonth;
//   }
//
//   List<Widget> dateDayCardlist() {
//     List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);
//     return daysOfMonth.map((item) {
//       return dateDayCard(
//         dayName: item.day,
//         date: item.date,
//       );
//     }).toList();
//   }
//
//   void _fetchCheckupsForSelectedDate() async {
//     List<Map<String, String>> data = await _checkupService.fetchCheckupsForDate(datePicked.value);
//     checkupList.assignAll(data);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Vx.white,
//       appBar: AppBar(
//         flexibleSpace: Padding(
//           padding: const EdgeInsets.only(top: 40.0),
//           child: Center(
//             child: "HISTORY".text.fontFamily(bebasNeue).size(30).make(),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: true,
//         elevation: 10,
//         leading: IconButton(
//           onPressed: () {
//             Get.to(const Home());
//           },
//           icon: const Icon(Icons.arrow_back_ios_outlined),
//         ).paddingOnly(top: 10),
//       ),
//       body: SingleChildScrollView(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const HeightBox(30),
//           Obx(
//                 () => dateRow(
//               dateTime: datePicked.value,
//               onPressCalender: calenderFunc,
//               nextMonthPress: nextMonth,
//               previousMonthPress: previousMonth,
//             ),
//           ),
//           const HeightBox(20),
//           SizedBox(
//             height: 100,
//             // width: context.screenWidth - 50,
//             width: context.screenWidth - 50,
//             child: Obx(
//                   () => VxSwiper.builder(
//                 itemCount: dateDayCardlist().length,
//                 aspectRatio: 5,
//                 viewportFraction: 0.25,
//                 itemBuilder: (context, index) => dateDayCardlist()[index],
//               ),
//             ),
//           ).paddingOnly(left: 30, right: 30),
//
//
//           SizedBox(
//             width: double.maxFinite,
//             height: 300,
//             child: Obx(
//                   () => ListView.builder(
//                 itemCount: checkupList.length,
//                 itemBuilder: (context, index) {
//                   final checkup = checkupList[index];
//                   return checkupRow(
//                     time: checkup['time'],
//                     bpm: checkup['Hr'],
//                   );
//                 },
//               ),
//             ),
//           ).paddingAll(50),
//           customButton(
//             title: "Delete",
//             buttonColor: green,
//             padding: (10, 10),
//             fontSize: 25,
//             font: bebasNeue,
//             textColor: Vx.white,
//             onPress: () {
//               List<DateDay> daysOfMonth = getDaysOfMonth(datePicked.value);
//             },
//           ).box.width(double.maxFinite).make().centered(),
//         ]).px12(),
//       ),
//     );
//   }
// }
//
