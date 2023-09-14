import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraStackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraStackPageState();
  }
}

class _LenraStackPageState extends UiBuilderState<LenraStackPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "stack",
        "children": [
          {
            "_type": "container",
            "decoration": {"color": 0xFFFF0000},
            "constraints": {
              "minWidth": 100,
              "maxWidth": 100,
              "minHeight": 100,
              "maxHeight": 100,
            },
            "child": {"_type": "text", "value": ""}
          },
          {
            "_type": "container",
            "decoration": {"color": 0xFF00FF00},
            "constraints": {
              "minWidth": 60,
              "maxWidth": 60,
              "minHeight": 60,
              "maxHeight": 60,
            },
            "child": {"_type": "text", "value": "This is stacked."}
          },
        ]
      }
    };
  }

  @override
  getData(Event event) {
    switch (event.code) {
      case "InitData":
        return true;
      default:
        return false;
    }
  }
}
