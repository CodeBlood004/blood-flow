import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraService {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isRecording = false;
  String? videoPath;

  CameraController get controller => _controller;
  Future<void> get initializeControllerFuture => _initializeControllerFuture;

  Future<void> initialize(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> startVideoRecording() async {
    if (!isRecording) {
      final directory = await getTemporaryDirectory();
      videoPath = join(directory.path, 'video.mp4');
      await _controller.startVideoRecording();
      isRecording = true;
    }
  }

  Future<Uint8List> captureFrame() async {
    final XFile file = await _controller.takePicture();
    final Uint8List bytes = await file.readAsBytes();
    final List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      bytes,
      quality: 80,
    );
    return Uint8List.fromList(compressedBytes);
  }

  Future<String?> stopVideoRecording() async {
    if (isRecording) {
      XFile file = await _controller.stopVideoRecording();
      isRecording = false;
      videoPath = file.path;
      return videoPath;
    }
    return null;
  }

  void dispose() {
    _controller.dispose();
  }
}
