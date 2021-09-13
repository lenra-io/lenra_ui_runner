import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  StreamController<Map<String, dynamic>> uiStreamController = StreamController();
  Map<String, dynamic> ui = {
    "root": {
      "type": "container",
      "children": [
        {
          "type": "text",
          "value": "test",
        },
        {
          "type": "button",
          "value": "MyButton",
        },
      ]
    }
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      uiStreamController.sink.add(ui);
    });

    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Scaffold(
          body: LenraUiBuilder(
            uiStream: uiStreamController,
            patchUiStream: StreamController(),
          ),
        ),
      ),
    );
  }
}
