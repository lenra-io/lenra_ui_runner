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
        "type": "container",
        "children": [
          {
            "type": "radio",
            "label": "Basic selected",
            "value": "a",
            "groupValue": "a",
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Disabled selected",
            "disabled": true,
            "value": "a",
            "groupValue": "a",
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Basic",
            "value": "a",
            "groupValue": "b",
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Disabled",
            "disabled": true,
            "value": "a",
            "groupValue": "b",
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Interactive 1",
            "value": "a",
            "groupValue": data,
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Interactive 2",
            "value": "b",
            "groupValue": data,
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "radio",
            "label": "Interactive 3",
            "value": "c",
            "groupValue": data,
            "listeners": {
              "onChange": {
                "code": "myCode",
              }
            }
          }
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    if (event.code == "InitData") {
      return "a";
    } else if (event.code == "myCode") {
      return event.event["value"];
    } else {
      return "a";
    }
  }
}
