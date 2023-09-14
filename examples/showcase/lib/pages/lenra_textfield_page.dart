import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import '../ui_builder.dart';

class LenraTextFieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraTextFieldPageState();
  }
}

class _LenraTextFieldPageState extends UiBuilderState<LenraTextFieldPage, String> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "direction": "vertical",
        "spacing": 4,
        "mainAxisAlignment": "spaceAround",
        "children": [
          {
            "_type": "container",
            "constraints": {
              "maxWidth": 400,
              "maxHeight": 100
            },
            "child": {
              "_type": "textfield",
              "value": data,
              "style": {
                "decoration": {
                  "icon": {
                    "_type": "icon",
                    "value": "star",
                  },
                  "filled": true,
                  "fillColor": 0xFFBBDEFB,
                  "border": {
                    "_type": "outline",
                  },
                  "hintText": "hint",
                  "helperText": "helper",
                  "labelText": "label",
                  "counterText": "${data.length}"
                },
              },
              "minLines": 3,
              "maxLines": 5,
              "onChanged": {"code": "CodeA"}
            },
          },
          {
            "_type": "flexible",
            "child": {"_type": "text", "value": data}
          }
        ]
      }
    };
  }

  @override
  getData(Event event) {
    switch (event.code) {
      case "CodeA":
        return (event as OnChangedEvent).data.value;
      default:
        return "zzzz";
    }
  }
}
