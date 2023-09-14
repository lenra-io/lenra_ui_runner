import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:showcase/ui_builder.dart';

class LenraOverlayEntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LenraOverlayEntryPageState();
  }
}

class _LenraOverlayEntryPageState extends UiBuilderState<LenraOverlayEntryPage, Map<String, dynamic>> {
  Map<String, dynamic> oldData = {
    "navigation": {"page": "home"},
    "data": {}
  };

  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {"root": getPage(data["navigation"]["page"], data)};
  }

  @override
  Map<String, dynamic> getData(Event event) {
    Map<String, dynamic> navigation = {"page": oldData["navigation"]["page"]};

    Map<String, dynamic> data = {
      "textfieldValue": oldData["data"].containsKey("textfieldValue") ? oldData["data"]["textfieldValue"] : ""
    };

    if (event.code == "NewPage") {
      navigation.addAll({"page": "newPage"});
      data.addAll({
        "showOverlay": true,
        "showOverlay2": false,
      });
    }

    if (event.code == "InitData") {
      navigation.addAll({"page": "home"});
      data.addAll({
        "showOverlay": false,
        "showOverlay2": true,
      });
    }

    if (event.code == "showOverlay") {
      data.addAll({
        "showOverlay": true,
        "showOverlay2": false,
      });
    }

    if (event.code == "hideOverlay") {
      data.addAll({
        "showOverlay": false,
        "showOverlay2": false,
      });
    }

    if (event.code == "CodeA") {
      data.addAll({
        "textfieldValue": (event as OnChangedEvent).data.value,
        "showOverlay": true,
        "showOverlay2": false,
      });
    }

    if (event.code == "hideOverlay2") {
      data.addAll({
        "showOverlay2": false,
      });
    }

    Map<String, dynamic> res = {"navigation": navigation, "data": data};
    oldData = res;
    return res;
  }

  List getOverlays(Map<String, dynamic> data) {
    return [
      {
        "_type": "overlayEntry",
        "showOverlay": data["data"].containsKey("showOverlay") ? data["data"]["showOverlay"] : false,
        "child": {
          "_type": "container",
          "decoration": {
            "color": 0x44000000,
          },
          "child": {
            "_type": "flex",
            "mainAxisAlignment": "center",
            "crossAxisAlignment": "center",
            "direction": "vertical",
            "spacing": 2,
            "children": [
              {
                "_type": "container",
                "decoration": {"color": 0xFFFFFFFF},
                "padding": {
                  "left": 2,
                  "right": 2,
                  "top": 2,
                  "bottom": 2,
                },
                "child": {
                  "_type": "flex",
                  "crossAxisAlignment": "center",
                  "direction": "vertical",
                  "spacing": 2,
                  "children": [
                    {"_type": "text", "value": "This is an overlay entry."},
                    {
                      "_type": "flex",
                      "direction": "horizontal",
                      "children": [
                        {
                          "_type": "flexible",
                          "child": {
                            "_type": "textfield",
                            "value": data["data"]["textfieldValue"],
                            "style": {
                              "decoration": {
                                "label": {
                                  "_type": "text",
                                  "value": "What is your name ?",
                                },
                                "hintText": "Pascal",
                              }
                            },
                            "minLines": 3,
                            "maxLines": 5,
                            "onChanged": {"code": "CodeA"}
                          }
                        },
                        {"_type": "text", "value": data["data"]["textfieldValue"]}
                      ]
                    },
                    {
                      "_type": "button",
                      "text": "New page",
                      "onPressed": {
                        "code": "NewPage",
                      }
                    },
                    {
                      "_type": "button",
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
        "_type": "overlayEntry",
        "showOverlay": data["data"].containsKey("showOverlay2") ? data["data"]["showOverlay2"] : true,
        "child": {
          "_type": "container",
          "decoration": {
            "color": 0x44000000,
          },
          "child": {
            "_type": "flex",
            "mainAxisAlignment": "center",
            "crossAxisAlignment": "center",
            "direction": "vertical",
            "children": [
              {
                "_type": "container",
                "decoration": {"color": 0xFFFFFFFF},
                "padding": {
                  "left": 2,
                  "right": 2,
                  "top": 2,
                  "bottom": 2,
                },
                "child": {
                  "_type": "flex",
                  "crossAxisAlignment": "center",
                  "direction": "vertical",
                  "spacing": 2,
                  "children": [
                    {
                      "_type": "text",
                      "value": "This is an overlay.",
                    },
                    {"_type": "text", "value": "You can close it by clicking on the button."},
                    {
                      "_type": "button",
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
      }
    ];
  }

  Map<String, dynamic> getPage(String pageName, Map<String, dynamic> data) {
    Map<String, dynamic> page = {};

    switch (pageName) {
      case "home":
        page = homePage();
        break;
      case "newPage":
        page = newPage();
        break;
      default:
        page = homePage();
    }

    return {
      "_type": "flex",
      "fillParent": true,
      "mainAxisAlignment": "center",
      "crossAxisAlignment": "center",
      "children": [...getOverlays(data), page]
    };
  }

  Map<String, dynamic> homePage() {
    return {
      "_type": "flex",
      "fillParent": true,
      "mainAxisAlignment": "center",
      "crossAxisAlignment": "center",
      "children": [
        {
          "_type": "flex",
          "mainAxisAlignment": "center",
          "crossAxisAlignment": "center",
          "direction": "vertical",
          "spacing": 2,
          "fillParent": true,
          "children": [
            {
              "_type": "text",
              "value": "You can show another overlay by clicking on the button below.",
            },
            {
              "_type": "button",
              "text": "Show",
              "onPressed": {
                "code": "showOverlay",
              }
            },
          ]
        },
      ]
    };
  }

  Map<String, dynamic> newPage() {
    return {
      "_type": "flex",
      "fillParent": true,
      "mainAxisAlignment": "center",
      "crossAxisAlignment": "center",
      "children": [
        {
          "_type": "flex",
          "mainAxisAlignment": "center",
          "crossAxisAlignment": "center",
          "direction": "vertical",
          "spacing": 2,
          "fillParent": true,
          "children": [
            {
              "_type": "text",
              "value": "This is another page.",
            },
            {
              "_type": "button",
              "text": "Go back to the first page",
              "onPressed": {
                "code": "InitData",
              }
            },
          ]
        },
      ]
    };
  }
}
