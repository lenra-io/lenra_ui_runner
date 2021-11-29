import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraFlexiblePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraFlexiblePageState();
  }
}

class _LenraFlexiblePageState extends UiBuilderState<LenraFlexiblePage, bool> {
  Map<String, dynamic> littleSquare(int color, int flex) {
    return {
      "type": "flexible",
      "fit": "tight",
      "flex": flex,
      "child": {
        "type": "container",
        "decoration": {
          "color": color,
        },
        "child": {"type": "text", "value": " "}
      }
    };
  }

  Map<String, dynamic> lineFlex(int color1, int color2, int flex) {
    return {
      "type": "flexible",
      "flex": flex,
      "child": {
        "type": "container",
        "child": {
          "type": "flex",
          "fillParent": true,
          "mainAxisAlignment": "spaceEvenly",
          "crossAxisAlignment": "stretch",
          "spacing": 1,
          "children": [
            littleSquare(color1, 1),
            littleSquare(color2, 4),
            littleSquare(color1, 1),
          ]
        }
      }
    };
  }

  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "direction": "vertical",
        "spacing": 1,
        "padding": {"top": 1, "bottom": 1, "right": 1, "left": 1},
        "fillParent": true,
        "children": [
          lineFlex(0xFFFF0000, 0xFF7000FF, 1),
          lineFlex(0xFF7000FF, 0xFF0000FF, 4),
          lineFlex(0xFFFF0000, 0xFF7000FF, 1),
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
