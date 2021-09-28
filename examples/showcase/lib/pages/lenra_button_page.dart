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
        "type": "flex",
        "children": [
          {
            "type": "button",
            "text": "basic",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "button",
            "text": "disabled",
            "disabled": true,
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "button",
            "text": "Changing value $data",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "button",
            "text": "large secondary",
            "size": "large",
            "mainStyle": "secondary",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "type": "button",
            "text": "small tertiary",
            "size": "small",
            "mainStyle": "tertiary",
            "onPressed": {
              "code": "myCode",
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
