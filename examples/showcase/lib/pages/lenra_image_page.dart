import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraImagePageState();
  }
}

class _LenraImagePageState extends UiBuilderState<LenraImagePage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "direction": "vertical",
        "spacing": 1,
        "children": [
          {"type": "image", "src": "https://avatars.githubusercontent.com/u/18312505?s=200&v=4"}
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return false;
  }
}
