import 'dart:async';

import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/components/events/event.dart';

import 'ui_builder_model.dart';

class MockChannelModel extends ChannelModel {
  UiBuilderModel uiBuilderModel;

  MockChannelModel({
    required this.uiBuilderModel,
  }) : super(contextModel: ContextModel(), socketModel: AppSocketModel("accessToken", "app"));

  @override
  Future sendEvent(Event notification) {
    final completer = Completer();
    uiBuilderModel.handleNotifications(notification, (response) => completer.complete(response));
    return completer.future;
  }
}
