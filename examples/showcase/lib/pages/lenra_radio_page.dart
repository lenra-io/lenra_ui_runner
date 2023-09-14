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
        "_type": "flex",
        "spacing": 2,
        "children": [
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Basic selected"},
              {
                "_type": "radio",
                "value": "a",
                "groupValue": "a",
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Disabled selected"},
              {
                "_type": "radio",
                "value": "a",
                "groupValue": "a",
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Basic"},
              {
                "_type": "radio",
                "value": "a",
                "groupValue": "b",
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Disabled"},
              {
                "_type": "radio",
                "value": "a",
                "groupValue": "b",
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Unselected Color"},
              {
                "_type": "radio",
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
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Interactive 1"},
              {
                "_type": "radio",
                "value": "a",
                "groupValue": data,
                "onPressed": {"code": "listenerA"}
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Interactive 2"},
              {
                "_type": "radio",
                "value": "b",
                "groupValue": data,
                "onPressed": {"code": "listenerB"}
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {"_type": "text", "value": "Interactive 3"},
              {
                "_type": "radio",
                "value": "c",
                "groupValue": data,
                "onPressed": {"code": "listenerC"}
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
      case "listenerA":
        return "a";
      case "listenerB":
        return "b";
      case "listenerC":
        return "c";
      default:
        return "a";
    }
  }
}
