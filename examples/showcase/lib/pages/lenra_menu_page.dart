import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraMenuPageState();
  }
}

class _LenraMenuPageState extends UiBuilderState<LenraMenuPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "menu",
            "children": [
              {
                "type": "menuItem",
                "text": "First",
                "isSelected": data == "first",
                "disabled": true,
                "icon": "ac_unit",
                "onPressed": {
                  "code": "first",
                }
              },
              {
                "type": "menuItem",
                "text": "Second",
                "isSelected": data == "second",
                "onPressed": {
                  "code": "second",
                }
              },
              {
                "type": "menuItem",
                "text": "Third",
                "isSelected": data == "third",
                "icon": "unarchive",
                "onPressed": {
                  "code": "third",
                }
              }
            ]
          },
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    print(event.code);
    return false;
  }
}
