import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import './ui_builder.dart';

class MyTestApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTestAppState();
  }
}

class _MyTestAppState extends UiBuilderState<MyTestApp, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "container",
        "children": [
          {
            "type": "text",
            "value": "test: $data",
          },
          {
            "type": "button",
            "text": "MyButton",
            "listeners": {
              "onClick": {
                "code": "myCode",
              }
            }
          },
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    if (event.code == "InitData") {
      return true;
    } else if (event.code == "myCode") {
      return !data;
    } else {
      return false;
    }
  }
}
