import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class MockSocketModel extends SocketModel {
  final PhoenixSocket _socket;

  MockSocketModel(int userId, String appName)
      : _socket = createPhoenixSocket(
          "ws://localhost:4001/socket/websocket",
          {"userId": userId.toString(), "app": appName},
        ) {
    _socket.connect();
  }

  @override
  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    return LenraChannel(_socket, channelName, params);
  }
}
