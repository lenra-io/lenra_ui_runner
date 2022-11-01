import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/models/widget_model.dart';

import 'mock_channel_model.dart';

void main() {
  test('Check parser working', () {
    WidgetModel model = WidgetModel(channelModel: MockChannelModel());
    var ui = {
      "root": {
        "children": [
          {"type": "text", "value": "Hello world!"},
          {
            "onChanged": {"code": "Xs1fWeAzGXy/a48lHpYjrfSs4xkRW4Bu2F1aVMajoyQ="},
            "type": "textfield",
            "value": "world"
          }
        ],
        "type": "flex"
      }
    };

    var patches = jsonDecode(jsonEncode([
      {"op": "replace", "path": "/root/children/1/value", "value": "worlds"},
      {"op": "replace", "path": "/root/children/0/value", "value": "Hello worlds!"}
    ]));

    var newUi = {
      "root": {
        "children": [
          {"type": "text", "value": "Hello worlds!"},
          {
            "onChanged": {"code": "Xs1fWeAzGXy/a48lHpYjrfSs4xkRW4Bu2F1aVMajoyQ="},
            "type": "textfield",
            "value": "worlds"
          }
        ],
        "type": "flex"
      }
    };

    model.replaceUi(ui);
    expect(model.ui, equals(ui));
    expect(() => model.patchUi(patches), throwsA(isA<TypeError>()));

    var parsedPatches = (patches as Iterable).map((e) => e as Map<String, dynamic>);
    model.patchUi(parsedPatches);
    expect(model.ui, equals(newUi));
  });
}
