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
        "type": "text",
        "value": "Test",
        "style": {
          "color": 0xFFFF0000,
          "fontSize": 20,
          "fontWeight": "bold",
          "fontStyle": "italic",
          "textDecoration": "underline",
        }
        // "children": [
        //   {
        //     "type": "text",
        //     "value": "Foo",
        //     "children": [
        //       {"type": "text", "value": "Baz"}
        //     ]
        //   },
        //   {"type": "text", "value": "Bar"}
        // ]
      }
    };
  }

  @override
  getData(Event event) {
    return true;
  }
}
