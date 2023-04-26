import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';

class Listener {
  String code;
  Listener(this.code) : super();

  Future run(BuildContext context, Event Function(String) eventBuilder) {
    return EventManager.of(context).sendEvent(eventBuilder(code));
  }
}
