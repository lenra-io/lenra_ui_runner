import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraStyledContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraStyledContainerPageState();
  }
}

class _LenraStyledContainerPageState extends UiBuilderState<LenraStyledContainerPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "styledContainer",
            "color": 0xFFFFFFFF,
            "child": {"type": "text", "value": "Styled Container"},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "borderRadius": {
              "topLeft": {
                "x": 5,
                "y": 5,
              },
              "topRight": {
                "x": 10,
                "y": 10,
              },
              "bottomLeft": {
                "x": 10,
                "y": 10,
              },
              "bottomRight": {
                "x": 5,
                "y": 5,
              }
            },
            "boxShadow": {
              "color": 0xFF444444,
              "blurRadius": 5,
              "spreadRadius": 5,
              "offset": {
                "dx": 5,
                "dy": 5,
              }
            }
          }
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return true;
  }
}
