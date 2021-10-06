import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraButton should work properly', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (Event e) {
            expect(e.code, "pressed");
            hasBeenNotified = true;
            return false;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "button",
        "text": "foo",
        "onPressed": {"code": "pressed"}
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    expect(hasBeenNotified, true);
  });
}
