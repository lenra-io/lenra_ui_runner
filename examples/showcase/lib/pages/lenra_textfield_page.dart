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
        "type": "flex",
        "direction": "vertical",
        "children": [
          {
            "type": "flex",
            "direction": "horizontal",
            "children": [
              {
                "type": "textfield",
                "value": data,
                "label": "Quel est votre Prénom ?",
                "hintText": "Pascal",
                "minLines": 3,
                "maxLines": 5,
                "size": "large",
                "onChanged": {"code": "CodeA"}
              },
              {"type": "text", "value": data}
            ]
          },
          {
            "type": "flex",
            "direction": "horizontal",
            "children": [
              {
                "type": "textfield",
                "value": "",
                "label": "Password manager",
                "size": "large",
                "onChanged": {"code": "CodeA"},
                "autofillHints": ["newPassword"]
              },
            ]
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
