import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraListController extends GetxController {
  final _cameras = Rx<List<CameraDescription>>([]);

  List<CameraDescription> get cameras => _cameras.value;

  Future<void> setCameras(List<CameraDescription> cameras) async {
    _cameras.value = cameras;
    update(); // Inform listeners about the change
  }
}


