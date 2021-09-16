import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraTogglePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraTogglePageState();
  }
}

class _LenraTogglePageState extends UiBuilderState<LenraTogglePage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "container",
        "children": [
          {
            "type": "toggle",
            "value": data,
            "label": "basic",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "toggle",
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
