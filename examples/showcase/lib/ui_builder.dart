import 'dart:async';

import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';

abstract class UiBuilderState<T extends StatefulWidget, D> extends State<T> {
  StreamController<Map<String, dynamic>> uiStreamController = StreamController();
  StreamController<Iterable<Map<String, dynamic>>> patchUiStream = StreamController();
  late Map<String, dynamic> lastUi;
  late D data;

  Map<String, dynamic> get ui;

  D getData(LenraEvent event);

  @override
  void initState() {
    super.initState();
    data = getData(
      LenraEvent(
        code: "InitData",
        event: {},
      ),
    );
    lastUi = ui;
    uiStreamController.sink.add(ui);
  }

  bool handleNotifications(LenraEvent notification) {
    data = getData(notification);
    var newUi = this.ui;
    var diff = JsonPatch.diff(lastUi, newUi);
    lastUi = newUi;
    patchUiStream.add(diff);

    return true;
  }

  @override
  void dispose() {
    uiStreamController.close();
    patchUiStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LenraEvent>(
      onNotification: (LenraEvent event) => this.handleNotifications(event),
      child: LenraUiBuilder(
        uiStream: uiStreamController,
        patchUiStream: patchUiStream,
      ),
    );
  }
}
