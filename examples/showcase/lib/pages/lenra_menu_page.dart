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
        "type": "container",
        "children": [
          {
            "type": "menu",
            "children": [
              {
                "type": "menuItem",
                "text": "First",
                "isSelected": true,
                "disabled": true,
                "icon": "ac_unit",
                "listeners": {
                  "onPressed": {
                    "code": "myCode",
                  }
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
    if (event.code == "InitData") {
      return true;
    } else if (event.code == "myCode") {
      return !data;
    } else {
      return false;
    }
  }
}
