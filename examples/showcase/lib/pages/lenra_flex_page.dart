import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraFlexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraFlexPageState();
  }
}

class _LenraFlexPageState extends UiBuilderState<LenraFlexPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "container",
        "backgroundColor": "888888",
        "children": [
          {
            "type": "container",
            "backgroundColor": "8899AA",
            "children": [
              {
                "type": "flex",
                "direction": "row",
                "spacing": 3,
                "children": [
                  {"type": "text", "value": "first"},
                  {"type": "text", "value": "second"}
                ]
              },
            ],
          },
          {
            "type": "container",
            "backgroundColor": "CCDDEE",
            "children": [
              {
                "type": "flex",
                "direction": "col",
                "spacing": 3,
                "children": [
                  {"type": "text", "value": "first"},
                  {"type": "text", "value": "second"}
                ]
              },
            ],
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
