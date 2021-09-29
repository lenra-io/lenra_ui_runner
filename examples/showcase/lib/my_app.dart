import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:showcase/ui_builder.dart';

class MyTestApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTestAppState();
  }
}

class MyData {
  bool isOn;
  List<String> elements;

  MyData(this.isOn, this.elements);

  void toggleIsOn() {
    isOn = !isOn;
  }

  void addElement() {
    elements.add("Foo");
  }
}

class _MyTestAppState extends UiBuilderState<MyTestApp, MyData> {
  @override
  Map<String, dynamic> get ui {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "styledContainer",
            "child": data.isOn
                ? {
                    "type": "button",
                    "text": "foo",
                  }
                : {
                    "type": "text",
                    "value": "bar",
                  }
          },
          {
            "type": "flex",
            "children": data.elements.map((e) => {"type": "text", "value": e}).toList(),
          },
          {
            "type": "button",
            "text": "toggle",
            "onPressed": {
              "code": "toggle",
            }
          },
          {
            "type": "button",
            "text": "add",
            "onPressed": {
              "code": "add",
            }
          },
        ]
      }
    };
  }

  @override
  getData(LenraEvent event) {
    if (event.code == "InitData") {
      return MyData(false, []);
    } else if (event.code == "toggle") {
      data.toggleIsOn();
    } else if (event.code == "add") {
      data.addElement();
    }
    return data;
  }
}
