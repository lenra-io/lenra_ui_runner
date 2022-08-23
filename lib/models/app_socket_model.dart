import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:client_common/config/config.dart';
import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AppSocketModel extends SocketModel {
  String accessToken;
  PhoenixSocket? _socket;

  AppSocketModel(this.accessToken) {
    _updateSocket();
  }

  void _updateSocket() {
    _socket?.disconnect();

    _socket = createPhoenixSocket(
      Config.instance.wsEndpoint,
      {"token": accessToken},
    );
    _socket?.connect();
  }

  void update(String accessToken) {
    this.accessToken = accessToken;
    _updateSocket();
    notifyListeners();
  }

  @override
  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    if (_socket == null) throw "Socket must not be null";

    return LenraChannel(_socket!, channelName, params);
  }
}
