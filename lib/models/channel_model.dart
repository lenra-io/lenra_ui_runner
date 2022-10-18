import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ChannelModel extends ChangeNotifier {
  LenraChannel? channel;
  bool hasError = false;
  bool _isInitialized = false;
  ApiError? error;
  late SocketModel socketModel;
  late ContextModel contextModel;

  ChannelModel({required this.socketModel, required this.contextModel});

  bool get isInitialized {
    return _isInitialized;
  }

  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  void createChannel(String appName) {
    channel = socketModel.channel("app", {"app": appName, "context": contextModel.toJson()});

    channel!.onError((response) {
      hasError = true;
      isInitialized = true;
      error = ApiError.fromJson(response as Map<String, dynamic>);
      notifyListeners();
    });
  }

  ChannelModel update(SocketModel socketModel) {
    this.socketModel = socketModel;

    return this;
  }

  void sendEvent(Event notification, Function(Map<dynamic, dynamic>) callback) {
    channel!.send('run', notification.toMap())!.receive("ok", (response) => callback(response!));
  }

  void close() {
    channel!.close();
  }
}
