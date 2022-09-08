import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraFormPageState();
  }
}

class _LenraFormPageState extends UiBuilderState<LenraFormPage, Map<String, dynamic>> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "form",
        "onSubmit": {"code": "submitted"},
        "child": {
          "type": "flex",
          "children": [
            {
              "type": "toggle",
              "name": "toggleValue",
              "value": data["toggle"],
              "onPressed": {"code": "toggled"}
            },
            {
              "type": "checkbox",
              "value": data["checkbox"],
              "name": "checkboxValue",
              "onPressed": {"code": "checked"}
            },
            {
              "type": "button",
              "text": "Submit",
              "submit": true,
            },
            {
              "type": "text",
              "value": "Form data : ${data['text']}",
            }
          ]
        }
      }
    };
  }

  @override
  getData(Event event) {
    if (event.code == "InitData") {
      return {
        "toggle": false,
        "checkbox": false,
        "text": "",
      };
    } else if (event.code == "toggled") {
      data["toggle"] = !data["toggle"];
      return data;
    } else if (event.code == "submitted") {
      data["text"] = (event.data as ValueData).value;
      return data;
    } else {
      return data;
    }
  }
}
