import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
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
        "type": "flex",
        "children": [
          {
            "type": "checkbox",
            "value": data,
            "label": "basic",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "checkbox",
            "value": !data,
            "label": "disabled",
            "disabled": true,
            "onPressed": {
              "code": "myCode",
            }
          },
        ]
      }
    };
  }

  @override
  getData(Event event) {
    if (event.code == "InitData") {
      return true;
    } else if (event.code == "myCode") {
      return !data;
    } else {
      return false;
    }
  }
}
