import 'dart:async';

import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('change simple property', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "text",
        "value": "foo",
      }
    };

    List<Map<String, dynamic>> patches = [
      {"path": "/root/value", "value": "bar", "op": "replace"}
    ];

    uiStream.add(ui);
    patchUiStream.add(patches);

    await tester.pump();
    expect(find.text("foo"), findsNothing);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('Remove children of flex', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "flex",
        "children": [
          {"type": "text", "value": "foo"}
        ]
      }
    };

    List<Map<String, dynamic>> patches = [
      {"path": "/root/children", "op": "remove"}
    ];

    uiStream.add(ui);
    await tester.pump();

    LenraUiBuilderState lenraUiBuilderState = tester.state(find.byType(LenraUiBuilder));

    expect(lenraUiBuilderState.wrappers.containsKey("/root/children/0"), true);

    patchUiStream.add(patches);
    await tester.pump();
    //    lenraUiBuilderState = tester.state(find.byType(LenraUiBuilder));
    expect(lenraUiBuilderState.wrappers.containsKey("/root/children/0"), false);
  });

  testWidgets('Change children of flex', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "flex",
        "children": [
          {"type": "text", "value": "foo"}
        ]
      }
    };

    List<Map<String, dynamic>> patches = [
      {
        "path": "/root/children",
        "value": [
          {"type": "text", "value": "bar"}
        ],
        "op": "replace"
      }
    ];

    uiStream.add(ui);
    patchUiStream.add(patches);
    await tester.pump();

    expect(find.text("foo"), findsNothing);
    expect(find.text("bar"), findsOneWidget);
  });
}
