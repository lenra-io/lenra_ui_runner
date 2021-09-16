import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraButtonPageState();
  }
}

class _LenraButtonPageState extends UiBuilderState<LenraButtonPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "container",
        "children": [
          {
            "type": "button",
            "text": "basic",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "button",
            "text": "disabled",
            "disabled": true,
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "button",
            "text": "Changing value $data",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "button",
            "text": "large secondary",
            "size": "large",
            "mainStyle": "secondary",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
          },
          {
            "type": "button",
            "text": "small tertiary",
            "size": "small",
            "mainStyle": "tertiary",
            "listeners": {
              "onPressed": {
                "code": "myCode",
              }
            }
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
