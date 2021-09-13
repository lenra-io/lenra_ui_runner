import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';
import 'package:lenra_ui_runner/ui_patch.dart';

class MyApp extends StatelessWidget {
  StreamController<Map<String, dynamic>> uiStreamController = StreamController();
  StreamController<Iterable<UiPatchEvent>> patchUiStream = StreamController();
  late Map<String, dynamic> ui;
  late dynamic data;

  bool handleNotifications(LenraEvent notification) {
    // TODO: Handle notif
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      uiStreamController.sink.add(ui);
    });

    return NotificationListener<LenraEvent>(
      onNotification: (LenraEvent event) => this.handleNotifications(event),
      child: LenraUiBuilder(
        uiStream: uiStreamController,
        patchUiStream: patchUiStream,
      ),
    );
  }
}
