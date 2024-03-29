import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraTextPageState();
  }
}

class _LenraTextPageState extends UiBuilderState<LenraTextPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "direction": "vertical",
        "spacing": "4",
        "children": [
          {
            "_type": "text",
            "value": "Test",
            "style": {
              "color": 0xFFFF0000,
              "fontSize": 20,
              "fontWeight": "bold",
              "fontStyle": "italic",
              "textDecoration": "underline",
            },
          },
          {
            "_type": "container",
            "constraints": {
              "maxWidth": 60,
              "minWidth": 60,
              "maxHeight": 200,
            },
            "child": {
              "_type": "text",
              "value": "This is a centered text.",
              "textAlign": "center",
            }
          },
          {
            "_type": "container",
            "constraints": {
              "maxWidth": 100,
              "minWidth": 100,
              "maxHeight": 200,
            },
            "child": {
              "_type": "text",
              "value": "This is a justified text. This is a justified text.",
              "textAlign": "justify",
            }
          },
          {
            "_type": "text",
            "value": "This text has children",
            "children": [
              {
                "style": {
                  "color": 0xFFFF0000,
                },
                "value": "Like this one"
              },
              {
                "style": {
                  "color": 0xFF00FF00,
                },
                "value": "Or this one"
              }
            ]
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
