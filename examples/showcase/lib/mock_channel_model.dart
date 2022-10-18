import 'dart:async';

import 'package:lenra_ui_runner/models/app_socket_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/socket/lenra_channel.dart';
import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:provider/provider.dart';

import 'ui_builder_model.dart';

class MockChannelModel extends ChannelModel {
  UiBuilderModel uiBuilderModel;

  MockChannelModel({
    required this.uiBuilderModel,
  }) : super(contextModel: ContextModel(), socketModel: AppSocketModel("accessToken"));

  Future sendEvent(Event notification) {
    final completer = Completer();
    uiBuilderModel.handleNotifications(notification, (response) => completer.complete(response));
    return completer.future;
  }
}
