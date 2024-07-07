import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<bool> uploadVideo(File videoFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://517e-103-151-46-8.ngrok-free.app/upload_video'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));
      var response = await request.send();

      return response.statusCode == 200;
    } catch (e) {
      print('Video upload failed with error: $e');
      return false;
    }
  }

  Future<String?> getHeartRate() async {
    try {
      var response = await http.get(Uri.parse('https://517e-103-151-46-8.ngrok-free.app/run_analysis'));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return (responseData['heart_rate'] as num).toInt().toString();
      } else {
        print('Failed to get heart rate with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to get heart rate with error: $e');
      return null;
    }
  }
}
