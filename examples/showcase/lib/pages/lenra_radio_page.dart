import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class RadioExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RadioExampleState();
  }
}

class _RadioExampleState extends UiBuilderState<RadioExample, String> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "spacing": 2,
        "children": [
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Basic selected"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": "a",
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Disabled selected"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": "a",
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Basic"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": "b",
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Disabled"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": "b",
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Unselected Color"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": "b",
                "style": {
                  "unselectedColor": 0xFFFF0000
                },
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Interactive 1"},
              {
                "type": "radio",
                "value": "a",
                "groupValue": data,
                "onPressed": {"code": "actionA"}
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Interactive 2"},
              {
                "type": "radio",
                "value": "b",
                "groupValue": data,
                "onPressed": {"code": "actionB"}
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"type": "text", "value": "Interactive 3"},
              {
                "type": "radio",
                "value": "c",
                "groupValue": data,
                "onPressed": {"code": "actionC"}
              }
            ]
          },
        ]
      }
    };
  }

  @override
  getData(Event event) {
    switch (event.code) {
      case "InitData":
        return "a";
      case "actionA":
        return "a";
      case "actionB":
        return "b";
      case "actionC":
        return "c";
      default:
        return "a";
    }
  }
}
