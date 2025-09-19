import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel channel;

  void connect(String username) {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://0.0.0.0:8000/ws/$username"),
    );
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  Stream get stream => channel.stream;

  void disconnect() {
    channel.sink.close();
  }
}
