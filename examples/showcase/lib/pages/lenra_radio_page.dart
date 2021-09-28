import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class RadioExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RadioExampleState();
  }
}

class _RadioExampleState extends UiBuilderState<RadioExample, String> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "radio",
            "label": "Basic selected",
            "value": "a",
            "groupValue": "a",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "radio",
            "label": "Disabled selected",
            "disabled": true,
            "value": "a",
            "groupValue": "a",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "radio",
            "label": "Basic",
            "value": "a",
            "groupValue": "b",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "radio",
            "label": "Disabled",
            "disabled": true,
            "value": "a",
            "groupValue": "b",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "radio",
            "label": "Interactive 1",
            "value": "a",
            "groupValue": data,
            "onPressed": {"code": "actionA"}
          },
          {
            "type": "radio",
            "label": "Interactive 2",
            "value": "b",
            "groupValue": data,
            "onPressed": {"code": "actionB"}
          },
          {
            "type": "radio",
            "label": "Interactive 3",
            "value": "c",
            "groupValue": data,
            "onPressed": {"code": "actionC"}
          }
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
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
