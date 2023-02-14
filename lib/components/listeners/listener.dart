import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/models/lenra_route_model.dart';
import 'package:provider/provider.dart';

abstract class Listener {
  String get code;
  Future run(BuildContext context, Event Function(String) eventBuilder);
}

class ActionListener extends Listener {
  @override
  String code;
  ActionListener(this.code) : super();

  @override
  Future run(BuildContext context, Event Function(String) eventBuilder) {
    return LenraRoute.of(context).sendEvent(eventBuilder(code));
  }
}

class NavListener extends Listener {
  String navTo;

  NavListener(this.navTo) : super();

  @override
  Future run(BuildContext context, Event Function(String) eventBuilder) {
    context.read<LenraRouteModel>().goTo(context, navTo);
    return Future<void>.value();
  }

  @override
  String get code => navTo;
}