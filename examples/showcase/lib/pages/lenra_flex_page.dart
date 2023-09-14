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
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "children": [
          {
            "_type": "flex",
            "children": [
              {
                "_type": "flex",
                "direction": "vertical",
                "spacing": 3,
                "children": [
                  {"_type": "text", "value": "first"},
                  {"_type": "text", "value": "second"}
                ]
              },
            ],
          },
          {
            "_type": "flex",
            "children": [
              {
                "_type": "flex",
                "direction": "vertical",
                "spacing": 3,
                "children": [
                  {"_type": "text", "value": "first"},
                  {"_type": "text", "value": "second"}
                ]
              },
            ],
          },
          {
            "_type": "container",
            "decoration": {
              "color": 0xffaabbcc,
            },
            "child": {
              "_type": "flex",
              "padding": {
                "top": 10,
                "left": 10,
                "right": 10,
                "bottom": 10,
              },
              "children": [
                {
                  "_type": "container",
                  "decoration": {
                    "color": 0xffffffff,
                  },
                  "child": {
                    "_type": "text",
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
