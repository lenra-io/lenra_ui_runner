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
        "_type": "flex",
        "children": [
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {
                "_type": "text",
                "value": "Basic",
              },
              {
                "_type": "toggle",
                "value": data,
                "onPressed": {
                  "code": "myCode",
                }
              },
            ]
          },
          {
            "_type": "flex",
            "crossAxisAlignment": "center",
            "children": [
              {
                "_type": "text",
                "value": "Disabled",
              },
              {
                "_type": "toggle",
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
