import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraButtonPageState();
  }
}

class _LenraButtonPageState extends UiBuilderState<LenraButtonPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "children": [
          {
            "_type": "button",
            "text": "basic",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "_type": "button",
            "text": "disabled",
            "disabled": true,
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "_type": "button",
            "text": "Changing value $data",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "_type": "button",
            "text": "large secondary",
            "size": "large",
            "mainStyle": "secondary",
            "onPressed": {
              "code": "myCode",
            }
          },
          {
            "_type": "button",
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
