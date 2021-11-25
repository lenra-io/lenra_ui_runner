import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraWrapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraWrapPageState();
  }
}

class _LenraWrapPageState extends UiBuilderState<LenraWrapPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "wrap",
        "alignment": "center",
        "children": [
          {
            "type": "wrap",
            "spacing": 15,
            "children": [
              {
                "type": "text",
                "value": "Foo",
              },
              {
                "type": "text",
                "value": "Wrapped",
              }
            ]
          },
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
