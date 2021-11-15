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
        "children": [
          {
            "type": "overlayEntry",
            "child": {
              "type": "text",
              "value": "Foo",
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
