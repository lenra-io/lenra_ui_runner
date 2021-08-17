import 'package:config/config.dart';
import 'package:models/auth_model.dart';
import 'package:models/socket_model.dart';
import 'package:socket/lenra_channel.dart';
import 'package:utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:utils/connexion_utils_web.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AppSocketModel extends SocketModel {
  AuthModel authModel;
  PhoenixSocket? _socket;

  AppSocketModel(this.authModel) {
    this._updateSocket();
  }

  void _updateSocket() {
    this._socket?.disconnect();

    if (this.authModel.isAuthenticated()) {
      this._socket = createPhoenixSocket(
        Config.instance.wsEndpoint,
        {"token": this.authModel.accessToken!},
      );
      this._socket?.connect();
    }
  }

  void update(AuthModel authModel) {
    this.authModel = authModel;
    this._updateSocket();
    notifyListeners();
  }

  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    if (this._socket == null) throw "Socket must not be null";

    return new LenraChannel(this._socket!, channelName, params);
  }
}
