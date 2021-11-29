import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraContainer test', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "container",
        "child": {"type": "text", "value": "foo"},
        "padding": {"top": 2.0, "bottom": 2.0, "right": 2.0, "left": 2.0},
        "constraints": {},
      }
    };

    uiStream.add(ui);
    await tester.pump();
    debugDumpApp();
    var container = find.byType(Container);
    expect(find.byType(LenraContainer), findsOneWidget);
    // expect(tester.widget<LenraContainer>(container).padding!.horizontal, 4);
    // expect(tester.widget<Container>(container).constraints!.minWidth, 0.0);
    // expect(tester.widget<Container>(container).color, Colors.red[900]);
  });
}
