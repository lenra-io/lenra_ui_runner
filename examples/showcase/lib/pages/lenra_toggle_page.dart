import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
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
        "type": "flex",
        "children": [
          {
            "type": "toggle",
            "value": data,
            "label": "basic",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "toggle",
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
