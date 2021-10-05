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
        "type": "flex",
        "backgroundColor": "888888",
        "children": [
          {
            "type": "flex",
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
            "type": "flex",
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
          {
            "type": "flex",
            "backgroundColor": 0xff0000dd,
            "padding": {
              "top": 100,
              "left": 100,
              "right": 100,
              "bottom": 100
            },
            "children": [
              {
                "type": "text",
                "value": "padding",
              }
            ]
          }
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
