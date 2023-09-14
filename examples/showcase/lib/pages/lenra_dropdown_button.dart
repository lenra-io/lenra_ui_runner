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
        "_type": "flex",
        "children": [
          {
            "_type": "dropdownButton",
            "text": "basic",
            "child": {
              "_type": "button",
              "text": "foo",
              "mainStyle": "secondary",
              "onPressed": {"code": "myCode"},
            },
          },
          {"_type": "text", "value": "$data"},
          {
            "_type": "dropdownButton",
            "text": "with icon",
            "child": {
              "_type": "text",
              "value": "foo",
            },
            "icon": {"_type": "icon", "value": "yard_sharp"},
          },
          {
            "_type": "dropdownButton",
            "text": "disabled",
            "disabled": true,
            "child": {
              "_type": "text",
              "value": "foo",
            }
          },
          {
            "_type": "dropdownButton",
            "text": "size & style",
            "size": "large",
            "mainStyle": "tertiary",
            "child": {
              "_type": "text",
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
