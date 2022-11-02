import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/io_components/lenra_router.dart';

abstract class Listener {
  String code;

  Listener(this.code);
  Future run(BuildContext context, Event Function(String) eventBuilder);
}

class ActionListener extends Listener {
  ActionListener(String code) : super(code);

  @override
  Future run(BuildContext context, Event Function(String) eventBuilder) {
    return LenraRoute.of(context).sendEvent(eventBuilder(code));
  }
}

class NavListener extends Listener {
  NavListener(String code) : super(code);

  @override
  Future run(BuildContext context, Event Function(String) eventBuilder) {
    return LenraRouter.of(context).navTo(context, code);
  }
}
