// import 'package:flutter/material.dart';
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/controller/route_controller.dart';
// import 'package:fitness_care/utils/utils.dart';
// import 'package:fitness_care/views/HR%20test%20screen/hr_screen.dart';
// import 'package:fitness_care/views/blood_flow_check/blood_flow_check.dart';
// import 'package:fitness_care/common%20widgets/circular_avatr.dart';
// import 'package:fitness_care/views/home/widget/heart_rate_summary.dart';
// import 'package:fitness_care/views/improvement_tips/improvement_tips.dart';
// import 'package:fitness_care/services/user_service.dart'; // import the UserService
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   RouteController routeController = Get.find<RouteController>();
//   final UserService _userService = UserService(); // create an instance of UserService
//
//   String fullName = "Loading...";
//   String profileImageUrl = "";
//   int currentHR = 0;
//   double weeklyAvgHR = 0;
//   int weeklyCheckups = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserName();
//     _fetchCheckupData();
//     _fetchProfileImageUrl();
//   }
//
//   void _fetchUserName() async {
//     String name = await _userService.fetchUserName();
//     setState(() {
//       fullName = name;
//     });
//   }
//
//   void _fetchCheckupData() async {
//     Map<String, dynamic> data = await _userService.fetchCheckupData();
//     setState(() {
//       currentHR = data['currentHR'];
//       weeklyAvgHR = data['weeklyAvgHR'];
//       weeklyCheckups = data['weeklyCheckups'];
//     });
//   }
//
//   void _fetchProfileImageUrl() async {
//     String imageUrl = await _userService.fetchProfileImageUrl();
//     setState(() {
//       profileImageUrl = imageUrl;
//     });
//   }
//
//
//   @override
//   void dispose() {
//     routeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Vx.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: screenHeight * 0.05),
//               circularProfile(
//                 image: profileImageUrl.isNotEmpty ? profileImageUrl : emptyProfileImage,
//                 name: fullName,
//                 isNetworkImage: profileImageUrl.isNotEmpty,
//               ),
//               SizedBox(height: screenHeight * 0.01),
//               heartRateSummary(currentHR: currentHR, weeklyAvgHR: weeklyAvgHR, weeklyCheckups: weeklyCheckups),
//               SizedBox(height: screenHeight * 0.08),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: customButton(
//                       title: "Blood Flow",
//                       buttonColor: black,
//                       textColor: Vx.white,
//                       padding: (screenWidth * 0.05, screenHeight * 0.015),
//                       onPress: () {
//                         Get.to(const BloodFlowScreen());
//                       },
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.03),
//                   Expanded(
//                     child: customButton(
//                       title: "Heart Rate",
//                       buttonColor: lightGray,
//                       textColor: black,
//                       padding: (screenWidth * 0.05, screenHeight * 0.015),
//                       onPress: () {
//                         Get.to(const HrScreen());
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.06),
//               customButton(
//                 title: "IMPROVEMENT TIPS",
//                 buttonColor: green,
//                 padding: (screenWidth * 0.05, screenHeight * 0.015),
//                 fontSize: 25,
//                 font: bebasNeue,
//                 textColor: Vx.white,
//                 onPress: () {
//                   Get.to(const ImprovementTips());
//                 },
//               ).box.width(double.maxFinite).make().centered(),
//             ],
//           ).paddingSymmetric(horizontal: screenWidth * 0.03),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:fitness_care/utils/utils.dart';
import 'package:fitness_care/views/HR%20test%20screen/hr_screen.dart';
import 'package:fitness_care/views/blood_flow_check/blood_flow_check.dart';
import 'package:fitness_care/common%20widgets/circular_avatr.dart';
import 'package:fitness_care/views/home/widget/heart_rate_summary.dart';
import 'package:fitness_care/views/improvement_tips/improvement_tips.dart';
import 'package:fitness_care/services/user_service.dart'; // import the UserService
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RouteController routeController = Get.find<RouteController>();
  final UserService _userService = UserService(); // create an instance of UserService

  String fullName = "Loading...";
  String profileImageUrl = "";
  int currentHR = 0;
  double weeklyAvgHR = 0;
  int weeklyCheckups = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchCheckupData();
    _fetchProfileImageUrl();
  }

  void _fetchUserName() async {
    String name = await _userService.fetchUserName();
    setState(() {
      fullName = name;
    });
  }

  void _fetchCheckupData() async {
    Map<String, dynamic> data = await _userService.fetchCheckupData();
    setState(() {
      currentHR = data['currentHR'];
      weeklyAvgHR = data['weeklyAvgHR'];
      weeklyCheckups = data['weeklyCheckups'];
    });
  }

  void _fetchProfileImageUrl() async {
    String imageUrl = await _userService.fetchProfileImageUrl();
    setState(() {
      profileImageUrl = imageUrl;
    });
  }

  @override
  void dispose() {
    routeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      backgroundColor: Vx.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              circularProfile(
                image: profileImageUrl.isNotEmpty ? profileImageUrl : emptyProfileImage,
                name: fullName,
                isNetworkImage: profileImageUrl.isNotEmpty,
              ),
              SizedBox(height: 10.h),
              heartRateSummary(
                  currentHR: currentHR,
                  weeklyAvgHR: weeklyAvgHR,
                  weeklyCheckups: weeklyCheckups
              ),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: customButton(
                      title: "Blood Flow",
                      buttonColor: black,
                      textColor: Vx.white,
                      padding: (0,12.h),
                      onPress: () {
                        Get.to(const BloodFlowScreen());
                      },
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: customButton(
                      title: "Heart Rate",
                      buttonColor: lightGray,
                      textColor: black,
                      padding: (0,12.h),
                      onPress: () {
                        Get.to(const HrScreen());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              customButton(
                title: "IMPROVEMENT TIPS",
                buttonColor: green,
                padding: (0,7.h),
                fontSize: 20.sp,
                font: bebasNeue,
                textColor: Vx.white,
                onPress: () {
                  Get.to(const ImprovementTips());
                },
              ).box.width(double.maxFinite).make().centered(),
            ],
          ).paddingSymmetric(horizontal: 24.w),
        ),
      ),
    );
  }
}
