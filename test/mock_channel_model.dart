import 'dart:async';

import 'package:lenra_ui_runner/models/app_socket_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/components/events/event.dart';

class MockChannelModel extends ChannelModel {
  MockChannelModel() : super(contextModel: ContextModel(), socketModel: AppSocketModel("accessToken", "app"));

  Function callback = (value) {};

  void setCallBack(Function function) {
    callback = function;
  }

  @override
  Future sendEvent(Event notification) {
    final completer = Completer();

    completer.future.then((value) => callback((value)));
    completer.complete(notification.toMap());
    return completer.future;
  }
}
