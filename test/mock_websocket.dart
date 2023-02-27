import 'dart:convert';
import 'dart:io';

import 'package:phoenix_wings/phoenix_wings.dart';

class MockWebSocket {
  HttpServer? _server;
  WebSocket? _socket;
  var heartbeat = 0;
  int port;
  String? heartbeatMessageReceived;

  MockWebSocket(this.port);

  start() async {
    _server = await HttpServer.bind("localhost", port, shared: true);
    _serve();
  }

  _serve() async {
    print("SERVING");
    await for (HttpRequest req in _server!) {
      print("SERVE AFTER AWAIT");
      print(req.uri.path);
      if (req.uri.path == '/socket/websocket') {
        _socket = await WebSocketTransformer.upgrade(req);
        _socket!.listen((msg) {
          final message = PhoenixSerializer.decode(msg);
          print("RECEIVED MESSAGE");
          print(message);
          if (message.event == 'heartbeat') {
            heartbeatMessageReceived = msg;
            handleHeartbeat(message);
          }
          if (message.event == 'test-push') {
            handleTestPush();
          }
        }, onError: (msg) {
          print("mock server socket error! $msg");
        });
      } else {
        req.response
          ..write("did not understand request: ${req.uri.path}")
          ..statusCode = HttpStatus.notFound
          ..close();
      }
    }
  }

  handleHeartbeat(message) {
    heartbeat++;
    final json = jsonEncode([
      null,
      "${message.ref}",
      "phoenix",
      "phx_reply",
      {"status": "ok", "response": {}}
    ]);
    sendMessage(json);
  }

  handleTestPush() {
    final success = jsonEncode([null, "ref", "phoenix", "phx_reply", {}]);
    sendMessage(success);
  }

  sendMessage(String msg) {
    print("msg");
    print(msg);
    print(_socket?.readyState);
    if (_socket?.readyState != WebSocket.open) {
      print("DOES NOT SEND MESSAGE");
      return;
    }
    _socket!.add(msg);
  }

  testDisconnect() async {
    await _socket?.close();
  }

  shutdown() async {
    await _server!.close();
    _server = null;
  }
}
