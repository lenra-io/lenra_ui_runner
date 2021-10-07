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
        "direction": "col",
        "children": [
          {"type": "text", "value": "headline1", "style": "headline1"},
          {"type": "text", "value": "headline2", "style": "headline2"},
          {"type": "text", "value": "headline3", "style": "headline3"},
          {"type": "text", "value": "headline4", "style": "headline4"},
          {"type": "text", "value": "headlineBody", "style": "headlineBody"},
          {"type": "text", "value": "bodyText", "style": "bodyText"},
          {"type": "text", "value": "blueBodyText", "style": "blueBodyText"},
          {"type": "text", "value": "subtext", "style": "subtext"},
          {"type": "text", "value": "disabledBodyText", "style": "disabledBodyText"},
          {"type": "text", "value": "underDescriptionText", "style": "underDescriptionText"},
          {"type": "text", "value": "errorText", "style": "errorText"},
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return true;
  }
}
