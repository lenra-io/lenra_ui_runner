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
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {"type": "headline1", "style": "headline1"},
          {"type": "headline2", "style": "headline2"},
          {"type": "headline3", "style": "headline3"},
          {"type": "headline4", "style": "headline4"},
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return true;
  }
}
