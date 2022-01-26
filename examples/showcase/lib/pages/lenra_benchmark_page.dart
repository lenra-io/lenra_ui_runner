import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraBenchmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraBenchmarkPageState();
  }
}

class _LenraBenchmarkPageState extends UiBuilderState<LenraBenchmarkPage, bool> {
  static Map<String, dynamic> genButton(String mainStyle) {
    return {
      "type": "button",
      "mainStyle": mainStyle,
      "text": "myButton",
      "onPressed": {"code": ""}
    };
  }

  static Map<String, dynamic> genRow(int x, String mainStyle) {
    return {
      "type": "flex",
      "children": List.generate(x, (i) => genButton(mainStyle)),
    };
  }

  static Map<String, dynamic> genCol(int y, int x, String mainStyle) {
    return {
      "type": "flex",
      "children": List.generate(y, (i) => genRow(x, mainStyle)),
      "direction": "vertical",
    };
  }

  Map<String, dynamic> cols10 = genCol(10, 10, "primary");
  Map<String, dynamic> cols5 = genCol(5, 5, "secondary");

  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "direction": "vertical",
        "children": [
          {
            "type": "flexible",
            "flex": 1,
            "child": data ? genCol(10, 10, "secondary") : genCol(11, 10, "secondary"),
          },
          {
            "type": "flex",
            "children": [
              {
                "type": "button",
                "text": "toggle",
                "onPressed": {"code": "toggle"}
              }
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
    } else if (event.code == "toggle") {
      return !data;
    } else {
      return data;
    }
  }
}
