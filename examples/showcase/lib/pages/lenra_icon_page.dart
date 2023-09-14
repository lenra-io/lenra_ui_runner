import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraIconPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraIconPageState();
  }
}

class _LenraIconPageState extends UiBuilderState<LenraIconPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "children": [
          {
            "_type": "icon",
            "value": "fingerprint_outlined",
            "color": 0xFFFF0000,
            "size": 200,
          },
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return true;
  }
}
