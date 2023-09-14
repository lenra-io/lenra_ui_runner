import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraContainerPageState();
  }
}

class _LenraContainerPageState extends UiBuilderState<LenraContainerPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "direction": "vertical",
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "fillParent": true,
        "spacing": 2,
        "children": [
          {
            "_type": "flex",
            "mainAxisAlignment": "center",
            "spacing": 2,
            "fillParent": true,
            "children": [
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFF9B69DE,
                },
                "child": {"_type": "text", "value": "Purple"}
              },
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFF4AC54A,
                },
                "child": {"_type": "text", "value": "Green"}
              },
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEE820E,
                },
                "child": {"_type": "text", "value": "Orange"}
              },
            ]
          },
          {
            "_type": "flex",
            "mainAxisAlignment": "center",
            "spacing": 2,
            "fillParent": true,
            "children": [
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEEEEEE,
                },
                "border": {
                  "top": {"width": 3, "color": 0xFF36D8F1},
                  "left": {"width": 3, "color": 0xFF36D8F1},
                  "bottom": {"width": 3, "color": 0xFF36D8F1},
                  "right": {"width": 3, "color": 0xFF36D8F1},
                },
                "child": {"_type": "text", "value": "Border Color"}
              },
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEEEEEE,
                },
                "border": {
                  "top": {"width": 1, "color": 0xFF000000},
                  "left": {"width": 1, "color": 0xFF000000},
                  "bottom": {"width": 1, "color": 0xFF000000},
                  "right": {"width": 1, "color": 0xFF000000},
                },
                "child": {"_type": "text", "value": "Border 1px"}
              },
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEEEEEE,
                  "borderRadius": {
                    "topLeft": {
                      "x": 10,
                      "y": 10,
                    },
                    "topRight": {
                      "x": 10,
                      "y": 10,
                    },
                    "bottomLeft": {
                      "x": 10,
                      "y": 10,
                    },
                    "bottomRight": {
                      "x": 10,
                      "y": 10,
                    },
                  },
                },
                "border": {
                  "top": {"width": 1, "color": 0xFF000000},
                  "left": {"width": 1, "color": 0xFF000000},
                  "bottom": {"width": 1, "color": 0xFF000000},
                  "right": {"width": 1, "color": 0xFF000000},
                },
                "child": {"_type": "text", "value": "border radius"}
              },
            ]
          },
          {
            "_type": "flex",
            "mainAxisAlignment": "center",
            "spacing": 3,
            "fillParent": true,
            "children": [
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEEEEEE,
                  "boxShadow": {
                    "color": 0xFF444444,
                    "blurRadius": 5,
                    "spreadRadius": 5,
                    "offset": {"dx": 5, "dy": 5}
                  }
                },
                "child": {"_type": "text", "value": "Shadow"}
              },
              {
                "_type": "container",
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "decoration": {
                  "color": 0xFFEEEEEE,
                  "boxShadow": {
                    "color": 0xFF9B69DE,
                    "blurRadius": 5,
                    "spreadRadius": 5,
                    "offset": {"dx": 5, "dy": 5}
                  }
                },
                "child": {"_type": "text", "value": "shadow color"}
              },
              {
                "_type": "container",
                "alignment": "center",
                "constraints": {
                  "minWidth": 80,
                  "minHeight": 80
                },
                "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                "border": {
                  "top": {"width": 3, "color": 0xFF000000},
                  "left": {"width": 3, "color": 0xFF000000},
                  "bottom": {"width": 3, "color": 0xFF000000},
                  "right": {"width": 3, "color": 0xFF000000},
                },
                "decoration": {
                  "color": 0xFFE0F7F4,
                  "borderRadius": {
                    "topLeft": {
                      "x": 10,
                      "y": 10,
                    },
                    "bottomRight": {
                      "x": 10,
                      "y": 10,
                    },
                  },
                  "boxShadow": {
                    "color": 0x42000000,
                    "blurRadius": 3,
                    "spreadRadius": 3,
                    "offset": {"dx": 5, "dy": 2}
                  }
                },
                "child": {"_type": "text", "value": "All in one"}
              },
            ]
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
