import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraOverlayEntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraOverlayEntryPageState();
  }
}

class _LenraOverlayEntryPageState extends UiBuilderState<LenraOverlayEntryPage, bool> {
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
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return false;
  }
}
