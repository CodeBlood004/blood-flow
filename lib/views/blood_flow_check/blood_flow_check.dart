import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:fitness_care/services/camera_service.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:fitness_care/controller/camera_list_controller.dart';
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/services/websocket_sevice.dart';

class BloodFlowScreen extends StatefulWidget {
  const BloodFlowScreen({super.key});

  @override
  State<BloodFlowScreen> createState() => _BloodFlowScreenState();
}

class _BloodFlowScreenState extends State<BloodFlowScreen> {
  RouteController routeController = Get.find<RouteController>();
  final CameraService _cameraService = CameraService();
  final WebSocketService _webSocketService = WebSocketService();
  bool _isStreaming = false;
  Uint8List? _processedFrame;

  @override
  void initState() {
    super.initState();
    final cameraListController = Get.find<CameraListController>();

    _cameraService.initialize(cameraListController.cameras[1]).then((_) {
      setState(() {});
    });

    _webSocketService.connect('ws://048f-103-151-46-8.ngrok-free.app/video');
    _webSocketService.onMessageReceived = (message) {
      setState(() {
        _processedFrame = message;
      });
    };
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _webSocketService.disconnect();
    super.dispose();
  }

  void _startStreaming() {
    setState(() {
      _isStreaming = true;
    });
    _streamVideo();
  }

  void _stopStreaming() {
    setState(() {
      _isStreaming = false;
    });
  }

  void _streamVideo() async {
    while (_isStreaming) {
      final Uint8List frame = await _cameraService.captureFrame();
      _webSocketService.sendMessage(frame);
      await Future.delayed(const Duration(milliseconds: 33));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Center(
            child: "BLOOD FLOW".text.fontFamily(bebasNeue).size(30.sp).make(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: _processedFrame == null
                          ? CameraPreview(_cameraService.controller).box.width(100.w).make()
                          : Image.memory(_processedFrame!).box.width(100.w).make(),
                    ).box.height(context.screenHeight / 3).width(context.screenWidth).roundedLg.make();
                  } else {
                    return const CircularProgressIndicator().centered();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: context.screenHeight / 3.5),
          customButton(
            title: _isStreaming ? "Stop Streaming" : "Start Streaming",
            buttonColor: green,
            textColor: Vx.white,
            padding: (50.w, 7.h),
            font: bebasNeue,
            fontSize: 20.sp,
            onPress: _isStreaming ? _stopStreaming : _startStreaming,
          ),
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(color: Colors.red, label: 'High Blood Flow'),
                SizedBox(height: 10.h),
                _buildIndicator(color: Colors.green, label: 'Moderate Blood Flow'),
                SizedBox(height: 10.h),
                _buildIndicator(color: Colors.yellow, label: 'Low Blood Flow'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          color: color,
        ),
        SizedBox(width: 8.w),
        Text(label, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }
}
