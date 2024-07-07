import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:fitness_care/services/firestroe_sevices.dart';
import 'package:lottie/lottie.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:fitness_care/controller/camera_list_controller.dart';
import 'package:fitness_care/services/camera_service.dart';
import 'package:fitness_care/services/network_service.dart';


class HrScreen extends StatefulWidget {
  const HrScreen({super.key});

  @override
  State<HrScreen> createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  RouteController routeController = Get.find<RouteController>();
  final CameraService _cameraService = CameraService();
  final NetworkService _networkService = NetworkService();
  final FirestoreService _firestoreService = FirestoreService();
  bool isRecording = false;
  String? heartRate;

  @override
  void initState() {
    super.initState();
    final cameraListController = Get.find<CameraListController>();

    _cameraService.initialize(cameraListController.cameras[1]).then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  Future<void> startVideoRecording() async {
    if (!isRecording) {
      try {
        await _cameraService.startVideoRecording();
        setState(() {
          isRecording = true;
        });
        Timer(const Duration(seconds: 25), stopVideoRecording);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> stopVideoRecording() async {
    if (isRecording) {
      try {
        String? videoPath = await _cameraService.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        if (videoPath != null) {
          bool uploadSuccess = await _networkService.uploadVideo(File(videoPath));
          if (uploadSuccess) {
            await fetchHeartRate();
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> fetchHeartRate() async {
    try {
      String? rate = await _networkService.getHeartRate();
      if (rate != null) {
        setState(() {
          heartRate = rate;
        });
        await _firestoreService.saveHeartRate(rate);
      }
    } catch (e) {
      print(e);
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
                future: _cameraService.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: CameraPreview(_cameraService.controller).box.width(100.w).make(),
                    ).box.height(context.screenHeight / 6).width(context.screenWidth).roundedLg.make();
                  } else {
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
                padding: (0.w, 7.h),
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
