import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';
import 'package:lenra_ui_runner/ui_patch.dart';

class UiBuilder extends StatefulWidget {
  State<UiBuilder> createState() => _UiBuilderState();
}

class _UiBuilderState extends State<UiBuilder> {
  StreamController<Map<String, dynamic>> uiStreamController = StreamController();
  StreamController<Iterable<UiPatchEvent>> patchUiStream = StreamController();
  late Map<String, dynamic> ui;
  late dynamic data;

  bool handleNotifications(LenraEvent notification) {
    // TODO: Handle notif
    return true;
  }

  @override
  void dispose() {
    this.uiStreamController.close();
    this.patchUiStream.close();
    super.dispose();
  }

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
