import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Check correctly built and listener working', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    bool listenerEntered = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "click");
            listenerEntered = true;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "clickListener",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onPressed": {
          "code": "click",
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    expect(listenerEntered, true);
  });
}
