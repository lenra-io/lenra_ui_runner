import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraOverlayEntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraOverlayEntryPageState();
  }
}

class _LenraOverlayEntryPageState extends UiBuilderState<LenraOverlayEntryPage, Map<String, dynamic>> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "fillParent": true,
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "children": [
          {
            "type": "overlayEntry",
            "child": {
              "type": "container",
              "decoration": {
                "color": 0x44000000,
              },
              "child": {
                "type": "flex",
                "mainAxisAlignment": "center",
                "crossAxisAlignment": "center",
                "children": [
                  {"type": "text", "value": "This is an overlay."},
                  {
                    "type": "button",
                    "text": "Foo",
                  }
                ]
              },
            }
          },
          {
            "type": "button",
            "text": "Show pop-up",
            "onPressed": {"code": "showPopUp"}
          },
          {"type": "flex", "children": data.containsKey("popups") ? data["popups"] : []}
        ]
      }
    };
  }

  @override
  getData(Event event) {
    if (event.code == "showPopUp") {
      return {
        "popups": [
          {
            "type": "overlayEntry",
            "child": {
              "type": "flex",
              "mainAxisAlignment": "center",
              "crossAxisAlignment": "end",
              "children": [
                {"type": "text", "value": "This is a pop-up."},
                {
                  "type": "button",
                  "text": "Foo",
                }
              ]
            }
          }
        ]
      };
    }

    return {};
  }
}
