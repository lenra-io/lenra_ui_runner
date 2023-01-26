import 'dart:async';

import 'package:lenra_ui_runner/models/socket_model.dart.old';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';

class MockSocketModel extends SocketModel {
  MockSocketModel() : super(contextModel: ContextModel(), socketModel: AppSocketModel("accessToken", "app"));

  LenraChannel channel(String routeName, Map<String, dynamic> params) {
    if (_socket == null) throw "Socket must not be null";

    return LenraChannel(_socket!, routeName, params);
  }
}
