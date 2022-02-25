import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/ui_builder.dart';

class LenraWrapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraWrapPageState();
  }
}

class _LenraWrapPageState extends UiBuilderState<LenraWrapPage, bool> {
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "wrap",
        "alignment": "center",
        "children": [
          {
            "type": "container",
            "padding": {"top": 8, "bottom": 8, "right": 8, "left": 8},
            "decoration": {"color": 0xFF03A9F8},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "child": {
              "type": "wrap",
              "spacing": 10,
              "children": [
                {
                  "type": "text",
                  "value": "Foo",
                },
                {
                  "type": "text",
                  "value": "Wrapped",
                }
              ]
            }
          },
          {
            "type": "container",
            "padding": {"top": 8, "bottom": 8, "right": 8, "left": 8},
            "decoration": {"color": 0xFF03A9F8},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "child": {
              "type": "wrap",
              "spacing": 10,
              "runspacing": 1,
              "children": [
                {
                  "type": "text",
                  "value": "Foo",
                },
                {
                  "type": "text",
                  "value": "Wrapped",
                }
              ]
            }
          },
          {
            "type": "container",
            "padding": {"top": 8, "bottom": 8, "right": 8, "left": 8},
            "decoration": {"color": 0xFF03A9F8},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "child": {
              "type": "wrap",
              "direction": "vertical",
              "spacing": 10,
              "children": [
                {
                  "type": "text",
                  "value": "Foo",
                },
                {
                  "type": "text",
                  "value": "Wrapped",
                }
              ]
            }
          },
          {
            "type": "container",
            "padding": {"top": 8, "bottom": 8, "right": 8, "left": 8},
            "decoration": {"color": 0xFF03A9F4},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "child": {
              "type": "wrap",
              "direction": "vertical",
              "spacing": 10,
              "runSpacing": 1,
              "children": [
                {
                  "type": "text",
                  "value": "Foo",
                },
                {
                  "type": "text",
                  "value": "Wrapped",
                }
              ]
            }
          },
          {
            "type": "container",
            "padding": {"top": 8, "bottom": 8, "right": 8, "left": 8},
            "decoration": {"color": 0xFF03A9F4},
            "border": {
              "top": {"width": 1.0, "color": 0xFF000000},
              "left": {"width": 1.0, "color": 0xFF000000},
              "bottom": {"width": 1.0, "color": 0xFF000000},
              "right": {"width": 1.0, "color": 0xFF000000},
            },
            "child": {
              "type": "wrap",
              "crossAxisAlignment": "start",
              "children": [
                {
                  "type": "container",
                  "padding": {"top": 5, "bottom": 5, "right": 5, "left": 5},
                  "decoration": {"color": 0xFF8BC34A},
                  "child": {"type": "text", "value": "foo"}
                },
                {
                  "type": "container",
                  "padding": {"top": 3, "bottom": 3, "right": 3, "left": 3},
                  "decoration": {"color": 0xFF8BC34A},
                  "child": {"type": "text", "value": "foo"}
                }
              ]
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
