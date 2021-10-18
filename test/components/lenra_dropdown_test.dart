import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Test on pressed in a child dropdownButton', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      NotificationListener(
          onNotification: (Event e) {
            expect(e.code, "yourCode");
            hasBeenNotified = true;
            return false;
          },
          child: createBaseTestWidgets(
            child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          )),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "dropdownButton",
        "text": "foo",
        "child": {
          "type": "button",
          "text": "bar",
          "onPressed": {"code": "myCode"},
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var dropdownButton = find.byType(LenraDropdownButton);
    expect(find.byType(LenraDropdownButton), findsOneWidget);
    await tester.tap(dropdownButton);
    await tester.pump();
    var button = find.text("bar");
    await tester.tap(button);
    expect(hasBeenNotified, true);
  });
}
