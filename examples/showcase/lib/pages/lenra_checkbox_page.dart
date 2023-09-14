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
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "crossAxisAlignment": "center",
        "children": [
          {
            "_type": "text",
            "value": "Basic Checkbox",
          },
          {
            "_type": "checkbox",
            "value": data["checkbox"],
            "onPressed": {
              "code": "checkbox",
            }
          },
          {
            "_type": "text",
            "value": "Disabled Checkbox",
          },
          {
            "_type": "checkbox",
            "value": data["checkbox"],
          },
          {
            "_type": "text",
            "value": "Tristate Checkbox",
          },
          {
            "_type": "checkbox",
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
