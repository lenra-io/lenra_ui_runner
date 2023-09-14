import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraStatusStickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraStatusStickerPageState();
  }
}

class _LenraStatusStickerPageState extends UiBuilderState<LenraStatusStickerPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "children": [
          {"_type": "statusSticker", "status": "success"},
          {"_type": "statusSticker", "status": "warning"},
          {"_type": "statusSticker", "status": "error"},
          {"_type": "statusSticker", "status": "pending"},
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
