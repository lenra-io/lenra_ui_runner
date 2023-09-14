import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraSliderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraSliderPageState();
  }
}

class _LenraSliderPageState extends UiBuilderState<LenraSliderPage, Map<String, dynamic>> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "children": [
          {
            "_type": "slider",
            "autofocus": true,
            "value": data["slider"],
            "divisions": 100,
            "label": data["slider"].round().toString(),
            "min": 0,
            "max": 100,
            "onChanged": {
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
      return {"slider": 50};
    } else if (event.code == "myCode") {
      return {"slider": event.data.toMap()["value"]};
    } else {
      return {};
    }
  }
}
