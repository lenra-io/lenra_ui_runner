import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
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
        "children": [
          {
            "type": "flex",
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
            "type": "container",
            "decoration": {
              "color": 0xffaabbcc,
            },
            "child": {
              "type": "flex",
              "padding": {
                "top": 10,
                "left": 10,
                "right": 10,
                "bottom": 10,
              },
              "children": [
                {
                  "type": "container",
                  "decoration": {
                    "color": 0xffffffff,
                  },
                  "child": {
                    "type": "text",
                    "value": "padding",
                  }
                }
              ]
            }
          }
        ]
      }
    };
  }

  @override
  getData(Event event) {
    if (event.code == "InitData") {
      return true;
    } else if (event.code == "myCode") {
      return !data;
    } else {
      return false;
    }
  }
}
