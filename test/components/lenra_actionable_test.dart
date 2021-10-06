import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Check correctly built and listener working', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    int eventsNb = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "doublePressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onDoublePressed": {
          "code": "doublePressed",
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });
}
