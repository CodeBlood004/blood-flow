
import 'package:fitness_care/views/HR%20test%20screen/hr_screen.dart';
import 'package:fitness_care/views/blood_flow_check/blood_flow_check.dart';
import 'package:fitness_care/views/history%20screen/history_screen.dart';
import 'package:fitness_care/views/home/home_screen.dart';
import 'package:fitness_care/views/profile_page/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class  RouteController extends GetxController{
  static final RouteController _instance = RouteController._internal();

  factory RouteController() {
    return _instance;
  }

  RouteController._internal();

  RxInt screenIndex = 0.obs;

  var pages = [
   const  Home(),
   const  ProfilePage(),
   const  HistoryScreen(),
  ];

  void updateScreenIndex(int newIndex) {
    screenIndex.value = newIndex;
  }

}


