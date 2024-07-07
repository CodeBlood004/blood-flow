// import 'dart:async';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:fitness_care/controller/route_controller.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'dart:convert';
// import 'package:path_provider/path_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/controller/camera_list_controller.dart';
// import 'package:lottie/lottie.dart';
//
// class HrScreen extends StatefulWidget {
//   const HrScreen({super.key});
//
//   @override
//   State<HrScreen> createState() => _HrScreenState();
// }
//
// class _HrScreenState extends State<HrScreen> {
//   RouteController routeController = Get.find<RouteController>();
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool isRecording = false;
//   String? videoPath;
//   String? heartRate;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     final cameraListController = Get.find<CameraListController>(); // Access CameraListController
//
//     _controller = CameraController(
//       cameraListController.cameras[1], // Assuming you want the first camera
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> startVideoRecording() async {
//     if (!isRecording) {
//       try {
//         await _initializeControllerFuture;
//         final directory = await getTemporaryDirectory();
//         videoPath = join(directory.path, 'video.mp4');
//         await _controller.startVideoRecording();
//         setState(() {
//           isRecording = true;
//         });
//         Timer(const Duration(seconds: 15), stopVideoRecording); // Record for 15 seconds
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   Future<void> stopVideoRecording() async {
//     if (isRecording) {
//       try {
//         XFile file = await _controller.stopVideoRecording();
//         setState(() {
//           isRecording = false;
//           videoPath = file.path;
//         });
//         await uploadVideo(File(videoPath!));
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   Future<void> uploadVideo(File videoFile) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://cefa-103-151-46-8.ngrok-free.app/upload_video'),
//       );
//       request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         print('Video uploaded successfully');
//         await getHeartRate();
//       } else {
//         print('Video upload failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Video upload failed with error: $e');
//     }
//   }
//
//   Future<void> getHeartRate() async {
//     try {
//       var response = await http.get(Uri.parse('https://cefa-103-151-46-8.ngrok-free.app/run_analysis'));
//
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         setState(() {
//           heartRate = (responseData['heart_rate'] as num).toInt().toString(); // Convert to int
//           print('heart rate : $heartRate');
//         });
//         await saveHeartRateToFirestore();
//       } else {
//         print('Failed to get heart rate with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Failed to get heart rate with error: $e');
//     }
//   }
//
//   Future<void> saveHeartRateToFirestore() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         String email = user.email!;
//         String checkupId = DateTime.now().millisecondsSinceEpoch.toString();
//         String time = DateTime.now().toIso8601String();
//
//         await _firestore.collection('users').doc(email).collection('checkup_list').doc(checkupId).set({
//           'time': time,
//           'Hr': heartRate,
//         });
//
//         print('Heart rate saved to Firestore');
//       }
//     } catch (e) {
//       print('Failed to save heart rate to Firestore: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           flexibleSpace:Padding(
//             padding: const EdgeInsets.only(top: 40.0),
//             child: Center(
//               child: "HEART RATE CHECK"
//                   .text
//                   .fontFamily(bebasNeue)
//                   .size(30)
//                   .make(),
//             ),
//           ),
//           centerTitle: true,
//           // backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: true,
//           elevation: 10,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios_outlined),
//           ).paddingOnly(top: 10)),
//       body: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               FutureBuilder<void>(
//                 future: _initializeControllerFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     // Controller is initialized
//                     return FittedBox(
//                       fit: BoxFit.cover,
//                       child: CameraPreview(_controller).box.width(100).make(),
//                     ).box.height(context.screenHeight / 6).width(context.screenWidth).roundedLg.make();
//                   } else {
//                     // Controller is initializing or hasn't been initialized yet
//                     return const CircularProgressIndicator().centered();
//                   }
//                 },
//               ),
//             ],
//           ),
//           HeightBox(context.screenHeight / 3),
//           "YOUR CURRENT HEART RATE IS"
//               .text
//               .fontFamily(bebasNeue)
//               .size(25)
//               .make(),
//           const HeightBox(5),
//           Lottie.asset(heatBeatGif, fit: BoxFit.fill)
//               .box
//               .width(100)
//               .height(80)
//               .make(),
//           heartRate != null
//               ? Text(
//             '$heartRate bpm',
//             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           )
//               : Container(),
//           "bmp".text.size(15).make(),
//           const HeightBox(50),
//           customButton(
//               title: isRecording ? "Stop" : "Start",
//               buttonColor: green,
//               textColor: Vx.white,
//               padding: (50, 10),
//               font: bebasNeue,
//               fontSize: 25,
//               onPress: isRecording ? stopVideoRecording : startVideoRecording),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/camera_list_controller.dart';
import 'package:lottie/lottie.dart';


class HrScreen extends StatefulWidget {
  const HrScreen({super.key});

  @override
  State<HrScreen> createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  RouteController routeController = Get.find<RouteController>();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isRecording = false;
  String? videoPath;
  String? heartRate;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    final cameraListController = Get.find<CameraListController>(); // Access CameraListController

    _controller = CameraController(
      cameraListController.cameras[1], // Assuming you want the first camera
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> startVideoRecording() async {
    if (!isRecording) {
      try {
        await _initializeControllerFuture;
        final directory = await getTemporaryDirectory();
        videoPath = join(directory.path, 'video.mp4');
        await _controller.startVideoRecording();
        setState(() {
          isRecording = true;
        });
        Timer(const Duration(seconds: 25), stopVideoRecording); // Record for 15 seconds
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> stopVideoRecording() async {
    if (isRecording) {
      try {
        XFile file = await _controller.stopVideoRecording();
        setState(() {
          isRecording = false;
          videoPath = file.path;
        });
        await uploadVideo(File(videoPath!));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> uploadVideo(File videoFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://4554-103-151-46-8.ngrok-free.app/upload_video'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
        await getHeartRate();
      } else {
        print('Video upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Video upload failed with error: $e');
    }
  }

  Future<void> getHeartRate() async {
    try {
      var response = await http.get(Uri.parse('https://4554-103-151-46-8.ngrok-free.app/run_analysis'));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          heartRate = (responseData['heart_rate'] as num).toInt().toString(); // Convert to int
          print('heart rate : $heartRate');
        });
        await saveHeartRateToFirestore();
      } else {
        print('Failed to get heart rate with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to get heart rate with error: $e');
    }
  }

  Future<void> saveHeartRateToFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email!;
        String checkupId = DateTime.now().millisecondsSinceEpoch.toString();
        String time = DateTime.now().toIso8601String();

        await _firestore.collection('users').doc(email).collection('checkup_list').doc(checkupId).set({
          'time': time,
          'Hr': heartRate,
        });

        print('Heart rate saved to Firestore');
      }
    } catch (e) {
      print('Failed to save heart rate to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Center(
            child: "HEART RATE CHECK"
                .text
                .fontFamily(bebasNeue)
                .size(30.sp)
                .make(),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 10,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ).paddingOnly(top: 10.h),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Controller is initialized
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: CameraPreview(_controller).box.width(100.w).make(),
                    ).box.height(context.screenHeight / 6).width(context.screenWidth).roundedLg.make();
                  } else {
                    // Controller is initializing or hasn't been initialized yet
                    return const CircularProgressIndicator().centered();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: context.screenHeight / 3),
          Column(
            children: [
              "YOUR CURRENT HEART RATE IS"
                  .text
                  .fontFamily(bebasNeue)
                  .size(25.sp)
                  .make(),
              SizedBox(height: 5.h),
              Lottie.asset(heatBeatGif, fit: BoxFit.fill)
                  .box
                  .width(100.w)
                  .height(80.h)
                  .make(),
              heartRate != null
                  ? Text(
                '$heartRate bpm',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              )
                  : Container(),
              "bpm".text.size(15.sp).make(),
              SizedBox(height: 50.h),
              customButton(
                title: isRecording ? "Stop" : "Start",
                buttonColor: green,
                textColor: Vx.white,
                padding: ( 0.w, 7.h),
                font: bebasNeue,
                fontSize: 20.sp,
                onPress: isRecording ? stopVideoRecording : startVideoRecording,
              ).box.width(double.maxFinite).make().centered(),
            ],
          ).paddingSymmetric(horizontal: 24.w),
        ],
      ),
    );
  }
}
