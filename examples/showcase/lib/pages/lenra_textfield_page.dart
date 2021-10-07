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
        "children": [
          {
            "type": "textfield",
            "value": "",
            "label": "Quel est votre Prénom ?",
            "hintText": "Pascal",
            "minLines": 3,
            "maxLines": 5,
            "size": "large",
            "onChanged": {"code": "CodeA"}
          },
          {"type": "text", "value": data}
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
        return "";
    }
  }
}
