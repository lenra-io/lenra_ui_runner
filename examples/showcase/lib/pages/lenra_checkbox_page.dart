import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraCheckboxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraCheckboxPageState();
  }
}

class _LenraCheckboxPageState extends UiBuilderState<LenraCheckboxPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "container",
        "children": [
          {
            "type": "checkbox",
            "value": data,
            "label": "basic",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "checkbox",
            "value": !data,
            "label": "disabled",
            "disabled": true,
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    if (event.code == "InitData") {
      return true;
    } else if (event.code == "myCode") {
      return !data;
    } else {
      return false;
    }
  }
}
