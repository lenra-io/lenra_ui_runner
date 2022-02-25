import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraDropdownButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraDropdownButtonPageState();
  }
}

class _LenraDropdownButtonPageState extends UiBuilderState<LenraDropdownButtonPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "dropdownButton",
            "text": "basic",
            "child": {
              "type": "button",
              "text": "foo",
              "mainStyle": "secondary",
              "onPressed": {"code": "myCode"},
            },
          },
          {"type": "text", "value": "$data"},
          {
            "type": "dropdownButton",
            "text": "with icon",
            "child": {
              "type": "text",
              "value": "foo",
            },
            "icon": {"type": "icon", "value": "yard_sharp"},
          },
          {
            "type": "dropdownButton",
            "text": "disabled",
            "disabled": true,
            "child": {
              "type": "text",
              "value": "foo",
            }
          },
          {
            "type": "dropdownButton",
            "text": "size & style",
            "size": "large",
            "mainStyle": "tertiary",
            "child": {
              "type": "text",
              "value": "foo",
            }
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
