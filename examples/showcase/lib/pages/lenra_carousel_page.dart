import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraCarouselPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraCarouselPage();
  }
}

class _LenraCarouselPage extends UiBuilderState<LenraCarouselPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "_type": "flex",
        "spacing": 16,
        "children": [
          {
            "_type": "container",
            "constraints": {
              "maxWidth": 200,
              "maxHeight": 200,
            },
            "child": {
              "_type": "carousel",
              "children": List<Map<String, dynamic>>.generate(
                40,
                (index) => {
                  "_type": "container",
                  "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                  "child": {
                    "_type": "container",
                    "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                    "decoration": {
                      "color": 0xFFA8A8A8,
                      "borderRadius": {
                        "topLeft": {
                          "x": 5,
                          "y": 5,
                        },
                        "bottomRight": {
                          "x": 5,
                          "y": 5,
                        },
                        "bottomLeft": {
                          "x": 5,
                          "y": 5,
                        },
                        "topRight": {
                          "x": 5,
                          "y": 5,
                        },
                      },
                    },
                    "child": {"_type": "text", "value": "This is element number $index"}
                  },
                },
              )
            },
          },
          {
            "_type": "container",
            "constraints": {
              "maxWidth": 200,
              "maxHeight": 200,
            },
            "child": {
              "_type": "carousel",
              "options": {
                "aspectRatio": 2.0,
                "enlargeCenterPage": true,
                "scrollDirection": "vertical",
              },
              "children": List<Map<String, dynamic>>.generate(
                40,
                (index) => {
                  "_type": "container",
                  "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                  "child": {
                    "_type": "container",
                    "padding": {"top": 8, "left": 8, "bottom": 8, "right": 8},
                    "decoration": {
                      "color": 0xFFA8A8A8,
                      "borderRadius": {
                        "topLeft": {
                          "x": 5,
                          "y": 5,
                        },
                        "bottomRight": {
                          "x": 5,
                          "y": 5,
                        },
                        "bottomLeft": {
                          "x": 5,
                          "y": 5,
                        },
                        "topRight": {
                          "x": 5,
                          "y": 5,
                        },
                      },
                    },
                    "child": {"_type": "text", "value": "This is element number $index"}
                  },
                },
              )
            }
          }
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
