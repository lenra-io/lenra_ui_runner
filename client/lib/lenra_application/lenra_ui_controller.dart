import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/events/lenra_event.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_builder.dart';
import 'package:fr_lenra_client/lenra_application/ui_patch.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';
import 'package:fr_lenra_client/socket/lenra_socket.dart';

class LenraUiController extends StatefulWidget {
  final String appName;

  LenraUiController(this.appName);

  @override
  State<StatefulWidget> createState() {
    return _LenraUiControllerState();
  }
}

class _LenraUiControllerState extends State<LenraUiController> {
  LenraChannel channel;
  StreamController<Map<String, dynamic>> uiStream;
  StreamController<Iterable<UiPatchEvent>> patchUiStream;

  @override
  void initState() {
    super.initState();
    channel = LenraSocket.instance.channel("app", {"app": widget.appName});
    uiStream = StreamController();
    patchUiStream = StreamController();

    channel.onUi((Map<String, dynamic> ui) {
      uiStream.add(ui);
    });

    channel.onPatchUi((Map<String, dynamic> json) {
      List<dynamic> patches = json["patch"] as List;
      Iterable<UiPatchEvent> parsedPatches = patches.map((patch) {
        return UiPatchEvent.fromPatch(patch as Map<String, dynamic>);
      }).toList();
      patchUiStream.add(parsedPatches);
    });
  }

  @override
  void dispose() {
    channel.close();
    uiStream.close();
    patchUiStream.close();
    super.dispose();
  }

  bool handleNotifications(LenraEvent notification) {
    if (notification.code != null) {
      this.channel.send('run', notification.toMap());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LenraEvent>(
      onNotification: (LenraEvent event) => this.handleNotifications(event),
      child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
    );
  }
}