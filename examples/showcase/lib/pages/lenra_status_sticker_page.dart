import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraStatusStickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraStatusStickerPageState();
  }
}

class _LenraStatusStickerPageState
    extends UiBuilderState<LenraStatusStickerPage, bool> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {"type": "statusSticker", "status": "success"},
          {"type": "statusSticker", "status": "warning"},
          {"type": "statusSticker", "status": "error"},
          {"type": "statusSticker", "status": "pending"},
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
