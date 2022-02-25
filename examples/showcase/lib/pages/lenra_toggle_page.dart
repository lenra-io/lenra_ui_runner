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
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {
                "type": "text",
                "value": "Basic",
              },
              {
                "type": "toggle",
                "value": data,
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {
                "type": "text",
                "value": "Disabled",
              },
              {
                "type": "toggle",
                "value": data,
              },
            ]
          }
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
