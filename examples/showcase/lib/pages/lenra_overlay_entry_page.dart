import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraOverlayEntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraOverlayEntryPageState();
  }
}

class _LenraOverlayEntryPageState extends UiBuilderState<LenraOverlayEntryPage, Map<String, dynamic>> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "fillParent": true,
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "children": [
          {
            "type": "flex",
            "mainAxisAlignment": "center",
            "crossAxisAlignment": "center",
            "direction": "vertical",
            "spacing": 2,
            "fillParent": true,
            "children": [
              {
                "type": "text",
                "value": "You can show another overlay by clicking on the button below.",
              },
              {
                "type": "button",
                "text": "Show",
                "onPressed": {
                  "code": "showOverlay",
                }
              },
            ]
          },
          {
            "type": "overlayEntry",
            "showOverlay": data.containsKey("showOverlay") ? data["showOverlay"] : false,
            "child": {
              "type": "container",
              "decoration": {
                "color": 0x44000000,
              },
              "child": {
                "type": "flex",
                "mainAxisAlignment": "center",
                "crossAxisAlignment": "center",
                "direction": "vertical",
                "spacing": 2,
                "children": [
                  {
                    "type": "container",
                    "decoration": {"color": 0xFFFFFFFF},
                    "padding": {
                      "left": 2,
                      "right": 2,
                      "top": 2,
                      "bottom": 2,
                    },
                    "child": {
                      "type": "flex",
                      "crossAxisAlignment": "center",
                      "direction": "vertical",
                      "spacing": 2,
                      "children": [
                        {"type": "text", "value": "This is an overlay entry."},
                        {
                          "type": "button",
                          "text": "Close",
                          "onPressed": {
                            "code": "hideOverlay",
                          }
                        }
                      ],
                    },
                  },
                ]
              },
            }
          },
          {
            "type": "overlayEntry",
            "showOverlay": data.containsKey("showOverlay2") ? data["showOverlay2"] : true,
            "child": {
              "type": "container",
              "decoration": {
                "color": 0x44000000,
              },
              "child": {
                "type": "flex",
                "mainAxisAlignment": "center",
                "crossAxisAlignment": "center",
                "direction": "vertical",
                "children": [
                  {
                    "type": "container",
                    "decoration": {"color": 0xFFFFFFFF},
                    "padding": {
                      "left": 2,
                      "right": 2,
                      "top": 2,
                      "bottom": 2,
                    },
                    "child": {
                      "type": "flex",
                      "crossAxisAlignment": "center",
                      "direction": "vertical",
                      "spacing": 2,
                      "children": [
                        {
                          "type": "text",
                          "value": "This is an overlay.",
                        },
                        {"type": "text", "value": "You can close it by clicking on the button."},
                        {
                          "type": "button",
                          "text": "Close",
                          "onPressed": {
                            "code": "hideOverlay2",
                          }
                        }
                      ]
                    }
                  },
                ]
              },
            }
          },
        ]
      }
    };
  }

  @override
  Map<String, dynamic> getData(Event event) {
    if (event.code == "InitData") {
      return {
        "showOverlay": false,
        "showOverlay2": true,
      };
    }

    if (event.code == "showOverlay") {
      return {"showOverlay": true, "showOverlay2": false};
    }

    if (event.code == "hideOverlay") {
      return {"showOverlay": false, "showOverlay2": false};
    }

    if (event.code == "hideOverlay2") {
      return {"showOverlay2": false};
    }

    return event.data.toMap();
  }
}
