import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraImagePageState();
  }
}

class _LenraImagePageState extends UiBuilderState<LenraImagePage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "direction": "horizontal",
        "spacing": 5,
        "children": [
          {"_type": "image", "src": "https://avatars.githubusercontent.com/u/18312505?s=200&v=4"},
          {
            "_type": "image",
            "src": "https://github.com/lenra-io/client-app/pull/19",
            "errorPlaceHolder": {
              "_type": "text",
              "value": "This is an error placeholder shown when an image encounters an error."
            }
          }
        ]
      }
    };
  }

  @override
  getData(Event event) {
    return false;
  }
}
