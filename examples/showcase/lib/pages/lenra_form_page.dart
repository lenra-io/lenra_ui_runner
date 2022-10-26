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
          "direction": "vertical",
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
              "type": "flexible",
              "child": {"type": "textfield", "value": "", "name": "t1"}
            },
            {
              "type": "flexible",
              "child": {"type": "textfield", "value": "", "name": "t2"}
            },
            {
              "type": "flexible",
              "child": {"type": "textfield", "value": "", "name": "t3"}
            },
            {
              "type": "flex",
              "children": [
                {
                  "type": "radio",
                  "name": "radioValue",
                  "value": "radio1",
                  "groupValue": data["radioValue"],
                },
                {
                  "type": "radio",
                  "name": "radioValue",
                  "value": "radio2",
                  "groupValue": data["radioValue"],
                }
              ]
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
        "radioValue": "radio1",
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
