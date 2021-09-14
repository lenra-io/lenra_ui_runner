import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_ui_runner/lenra_ui_builder.dart';
import 'package:showcase/ui_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> ui = {
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
    return LenraTheme(
      themeData: LenraThemeData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Scaffold(
          body: UiBuilder(),
        ),
      ),
    );
  }
}
