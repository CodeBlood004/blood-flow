import 'dart:async';
import 'package:camera/camera.dart';
import 'package:fitness_care/common%20widgets/custom_nav_bar.dart';
import 'package:fitness_care/controller/camera_list_controller.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:fitness_care/views/HR%20test%20screen/hr_screen.dart';
import 'package:fitness_care/views/blood_flow_check/blood_flow_check.dart';
import 'package:fitness_care/views/get_started/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_care/views/home/home_screen.dart';
import 'package:fitness_care/views/improvement_tips/improvement_tips.dart';
import 'package:fitness_care/views/profile_page/edit_profile.dart';
import 'package:fitness_care/views/profile_page/profile_page.dart';
import 'package:fitness_care/views/signup_screen/signup_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final cameras = await availableCameras();

  // Initialize CameraListController
  final cameraListController = Get.put(CameraListController());
  await cameraListController.setCameras(cameras); // Set initial cameras
  Get.put(RouteController());

  runApp(const MyApp());
}

class MyApp extends GetMaterialApp {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Vx.black)),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(primary: Vx.gray300),
        focusColor: green,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontSize: 18,
          ),
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home:  const GetStarted(),
    );
  }
}
