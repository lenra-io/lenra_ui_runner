import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';
import 'package:lenra_ui_runner/ui_patch.dart';

class UiBuilder extends StatefulWidget {
  final Map<String, dynamic> ui;

  UiBuilder({
    Key? key,
    required this.ui,
  }) : super(key: key);

  State<UiBuilder> createState() => _UiBuilderState();
}

class _UiBuilderState extends State<UiBuilder> {
  StreamController<Map<String, dynamic>> uiStreamController = StreamController();
  StreamController<Iterable<UiPatchEvent>> patchUiStream = StreamController();
  late Map<String, dynamic> _ui;
  late dynamic data;

  @override
  void initState() {
    super.initState();
    _ui = widget.ui;
  }

  bool handleNotifications(LenraEvent notification) {
    // TODO: Handle notif
    print(notification.toString());
    print(notification.toMap());
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
      uiStreamController.sink.add(_ui);
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
