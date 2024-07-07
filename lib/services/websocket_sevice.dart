import 'dart:convert';
import 'dart:typed_data';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  late IOWebSocketChannel _channel;
  Function(Uint8List)? onMessageReceived;

  void connect(String url) {
    _channel = IOWebSocketChannel.connect(url);
    _channel.stream.listen((message) {
      if (onMessageReceived != null) {
        onMessageReceived!(base64Decode(message));
      }
    });
  }

  void sendMessage(Uint8List message) {
    final String base64String = base64Encode(message);
    _channel.sink.add(base64String);
  }

  void disconnect() {
    _channel.sink.close(status.goingAway);
  }
}
