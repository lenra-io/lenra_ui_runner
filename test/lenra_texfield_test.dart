import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';

import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('check textfield properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "textfield",
        "value": "foo",
        "label": "bar",
        "onChanged": {"code": "yourCode"},
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('test onChanged', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    bool isEnterNotification = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
          child: NotificationListener(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
        onNotification: (LenraEvent e) {
          isEnterNotification = true;
          expect(e.code, "yourCode");
          expect(e.event["value"], "foo");
          return false;
        },
      )),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "textfield",
        "value": "",
        "onChanged": {"code": "yourCode"},
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var textfield = find.byType(TextField);
    await tester.enterText(textfield, "foo");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(isEnterNotification, true);
  });
}
