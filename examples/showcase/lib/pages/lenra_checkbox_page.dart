import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraCheckboxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraCheckboxPageState();
  }
}

class _LenraCheckboxPageState extends UiBuilderState<LenraCheckboxPage, Map<String, dynamic>> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "crossAxisAlignment": "center",
        "children": [
          {
            "type": "text",
            "value": "Basic Checkbox",
          },
          {
            "type": "checkbox",
            "value": data["checkbox"],
            "onPressed": {
              "code": "checkbox",
            }
          },
          {
            "type": "text",
            "value": "Disabled Checkbox",
          },
          {
            "type": "checkbox",
            "value": data["checkbox"],
          },
          {
            "type": "text",
            "value": "Tristate Checkbox",
          },
          {
            "type": "checkbox",
            "value": data["tristate"],
            "tristate": true,
            "onPressed": {
              "code": "tristate"
            }
          },
        ]
      }
    };
  }

  @override
  getData(Event event) {
    if (event.code == "InitData") {
      return {"checkbox": true, "tristate": false};
    } else if (event.code == "checkbox") {
      data.addAll({"checkbox": event.data.toMap()["value"]});
      return data;
    } else if (event.code == "tristate") {
      data.addAll({"tristate": event.data.toMap()["value"]});
      return data;
    } else {
      return data;
    }
  }
}
