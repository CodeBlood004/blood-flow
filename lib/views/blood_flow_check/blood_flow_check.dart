// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:camera/camera.dart';
// import 'package:fitness_care/common%20widgets/custom_nav_bar.dart';
// import 'package:fitness_care/controller/route_controller.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:fitness_care/common%20widgets/custom_button.dart';
// import 'package:fitness_care/consts/imports.dart';
// import 'package:fitness_care/controller/camera_list_controller.dart';
//
// class BloodFlowScreen extends StatefulWidget {
//   const BloodFlowScreen({super.key});
//
//   @override
//   State<BloodFlowScreen> createState() => _BloodFlowScreenState();
// }
//
// class _BloodFlowScreenState extends State<BloodFlowScreen> {
//   RouteController routeController = Get.find<RouteController>();
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late IOWebSocketChannel _channel;
//   bool _isStreaming = false;
//   Uint8List? _processedFrame;
//
//   @override
//   void initState() {
//     super.initState();
//     final cameraListController = Get.find<CameraListController>();
//
//     _controller = CameraController(
//       cameraListController.cameras[1], // Assuming you want the second camera
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     _initializeControllerFuture = _controller.initialize();
//
//     _channel = IOWebSocketChannel.connect('ws://127.0.0.1:5000/video');
//     _channel.stream.listen((message) {
//       setState(() {
//         _processedFrame = base64Decode(message);
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _channel.sink.close(status.goingAway);
//     super.dispose();
//   }
//
//   void _startStreaming() {
//     setState(() {
//       _isStreaming = true;
//     });
//     _streamVideo();
//   }
//
//   void _stopStreaming() {
//     setState(() {
//       _isStreaming = false;
//     });
//   }
//
//   void _streamVideo() async {
//     while (_isStreaming) {
//       final XFile file = await _controller.takePicture();
//       final Uint8List bytes = await file.readAsBytes();
//       final List<int> compressedBytes = await FlutterImageCompress.compressWithList(
//         bytes,
//         quality: 80, // Adjust quality as needed
//       );
//       final String base64String = base64Encode(compressedBytes);
//       _channel.sink.add(base64String);
//       await Future.delayed(const Duration(milliseconds: 33)); // Adjust delay as needed
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Padding(
//           padding: const EdgeInsets.only(top: 40.0),
//           child: Center(
//             child: "BLOOD FLOW"
//                 .text
//                 .fontFamily(bebasNeue)
//                 .size(30)
//                 .make(),
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         elevation: 10,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_ios_outlined),
//         ).paddingOnly(top: 10),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
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
//                       child: _processedFrame == null
//                           ? CameraPreview(_controller).box.width(100).make()
//                           : Image.memory(_processedFrame!).box.width(100).make(),
//                     ).box.height(context.screenHeight / 3).width(context.screenWidth).roundedLg.make();
//                   } else {
//                     // Controller is initializing or hasn't been initialized yet
//                     return const CircularProgressIndicator().centered();
//                   }
//                 },
//               ),
//             ],
//           ),
//           HeightBox(context.screenHeight / 4),
//           customButton(
//             title: _isStreaming ? "Stop Streaming" : "Start Streaming",
//             buttonColor: green,
//             textColor: Vx.white,
//             padding: ( 50, 10),
//             font: bebasNeue,
//             fontSize: 25,
//             onPress: _isStreaming ? _stopStreaming : _startStreaming,
//           ),
//           const SizedBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildIndicator(color: Colors.red, label: 'High Blood Flow'),
//                 _buildIndicator(color: Colors.green, label: 'Moderate Blood Flow'),
//                 _buildIndicator(color: Colors.blue, label: 'Low Blood Flow'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIndicator({required Color color, required String label}) {
//     return Row(
//
//       children: [
//         Container(
//           width: 20,
//           height: 20,
//           color: color,
//         ),
//         const SizedBox(width: 8),
//         Text(label),
//       ],
//     );
//   }
// }




import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:fitness_care/common%20widgets/custom_button.dart';
import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/camera_list_controller.dart';


class BloodFlowScreen extends StatefulWidget {
  const BloodFlowScreen({super.key});

  @override
  State<BloodFlowScreen> createState() => _BloodFlowScreenState();
}

class _BloodFlowScreenState extends State<BloodFlowScreen> {
  RouteController routeController = Get.find<RouteController>();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late IOWebSocketChannel _channel;
  bool _isStreaming = false;
  Uint8List? _processedFrame;

  @override
  void initState() {
    super.initState();
    final cameraListController = Get.find<CameraListController>();

    _controller = CameraController(
      cameraListController.cameras[1], // Assuming you want the second camera
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();

    _channel = IOWebSocketChannel.connect('ws://79d9-103-151-46-8.ngrok-free.app/video');
    _channel.stream.listen((message) {
      setState(() {
        _processedFrame = base64Decode(message);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _channel.sink.close(status.goingAway);
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
      final XFile file = await _controller.takePicture();
      final Uint8List bytes = await file.readAsBytes();
      final List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        bytes,
        quality: 80, // Adjust quality as needed
      );
      final String base64String = base64Encode(compressedBytes);
      _channel.sink.add(base64String);
      await Future.delayed(const Duration(milliseconds: 33)); // Adjust delay as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Center(
            child: "BLOOD FLOW"
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: _processedFrame == null
                          ? CameraPreview(_controller).box.width(100.w).make()
                          : Image.memory(_processedFrame!).box.width(100.w).make(),
                    ).box.height(context.screenHeight / 3).width(context.screenWidth).roundedLg.make();
                  } else {
                    // Controller is initializing or hasn't been initialized yet
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
            padding: ( 50.w, 7.h),
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
