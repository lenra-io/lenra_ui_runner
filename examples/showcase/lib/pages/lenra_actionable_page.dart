import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraActionablePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraActionablePage();
  }
}

class _LenraActionablePage extends UiBuilderState<LenraActionablePage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "children": [
          {
            "_type": "container",
            "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
            "decoration": {
              "color": 0xFF9B69DE,
            },
            "child": {
              "_type": "actionable",
              "child": {"_type": "text", "value": "Purple"}
            },
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
