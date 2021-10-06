import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraTextFieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraTextFieldPageState();
  }
}

class _LenraTextFieldPageState
    extends UiBuilderState<LenraTextFieldPage, String> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "textfield",
            "value": "",
            "label": "Quel est votre Prénom ?",
            "hintText": "Pascal",
            "onChanged": {"code": "CodeA"}
          },
          {"type": "text", "value": data}
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    switch (event.code) {
      case "CodeA":
        return event.event["value"];
      default:
        return "";
    }
  }
}
