import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:client_common/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:client_common/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:client_common/utils/connexion_utils_web.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class SocketModel extends ChangeNotifier {
  String accessToken;
  String appName;
  String wsEndpoint;
  Map<String, String> customParams;
  PhoenixSocket? _socket;

  SocketModel({
    required this.wsEndpoint,
    required this.accessToken,
    required this.appName,
    this.customParams = const <String, String>{},
  }) {
    _updateSocket();
  }

  void _updateSocket() {
    _socket?.disconnect();
    Map<String, String> baseParams = {"token": accessToken, "app": appName};
    baseParams.addAll(customParams);

    _socket = createPhoenixSocket(
      wsEndpoint,
      baseParams,
    );
    _socket?.connect();
  }

  void update(String accessToken) {
    this.accessToken = accessToken;
    _updateSocket();
    notifyListeners();
  }

  @override
  LenraChannel channel(String routeName, Map<String, dynamic> params) {
    if (_socket == null) throw "Socket must not be null";

    return LenraChannel(_socket!, routeName, params);
  }
}
