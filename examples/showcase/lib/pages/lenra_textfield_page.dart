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
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "direction": "vertical",
        "children": [
          {
            "type": "container",
            "constraints": {
              "maxWidth": 400,
              "maxHeight": 100
            },
            "child": {
              "type": "textfield",
              "style": {
                "decoration": {
                  // "icon": {
                  //   "type": "icon",
                  //   "value": "star",
                  // },
                  "filled": true,
                  "fillColor": 0xFFBBDEFB,
                  "border": {
                    "type": "outline",
                  },
                  "hintText": "hint",
                  "helperText": "helper",
                  "labelText": "label",
                  "counterText": "counter"
                },
              },
              "minLines": 3,
              "maxLines": 5,
              "onChanged": {"code": "CodeA"}
            },
          },
          {
            "type": "flexible",
            "child": {"type": "text", "value": data}
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
