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
        "_type": "form",
        "onSubmit": {"code": "submitted"},
        "child": {
          "_type": "flex",
          "direction": "vertical",
          "children": [
            {
              "_type": "toggle",
              "name": "toggleValue",
              "value": data["toggle"],
              "onPressed": {"code": "toggled"}
            },
            {
              "_type": "checkbox",
              "value": data["checkbox"],
              "name": "checkboxValue",
              "onPressed": {"code": "checked"}
            },
            {
              "_type": "flexible",
              "child": {"_type": "textfield", "value": "", "name": "t1"}
            },
            {
              "_type": "flexible",
              "child": {"_type": "textfield", "value": "", "name": "t2"}
            },
            {
              "_type": "flexible",
              "child": {"_type": "textfield", "value": "", "name": "t3"}
            },
            {
              "_type": "flex",
              "children": [
                {
                  "_type": "radio",
                  "name": "radioValue",
                  "value": "radio1",
                  "groupValue": data["radioValue"],
                },
                {
                  "_type": "radio",
                  "name": "radioValue",
                  "value": "radio2",
                  "groupValue": data["radioValue"],
                }
              ]
            },
            {
              "_type": "button",
              "text": "Submit",
              "submit": true,
            },
            {
              "_type": "text",
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
