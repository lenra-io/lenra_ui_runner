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
            "child": {"type": "text", "value": "Styled Container"},
            "border": {
              "top": {"width": 1.0, "color": "#001122"},
              "left": {"width": 2.0, "color": "#112233"},
              "bottom": {"width": 3.0, "color": "#223344"},
              "right": {"width": 4.0, "color": "#334455"},
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
              "color": "#444444",
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
