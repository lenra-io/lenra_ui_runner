import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraRadio should work properly', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "radio",
        "value": "foo",
        "groupValue": "bar",
        "autofocus": true,
        "materialTapTargetSize": "padded",
        "toggleable": false,
        "style": {
          "activeColor": 0xFF000000,
          "focusColor": 0xFF000000,
          "hoverColor": 0xFF000000,
          "splashRadius": 2,
          "visualDensity": "comfortable",
        }
      }
    };

    uiStream.add(ui);
    await tester.pump();
    LenraRadio<String> tmp = LenraRadio<String>(
      value: "foo",
      groupValue: "bar",
      onPressed: null,
    );

    var finderRadio = find.byType(tmp.runtimeType);
    var radio = tester.widget<LenraRadio>(finderRadio);
    expect(finderRadio, findsOneWidget);
    expect(radio.value, "foo");
    expect(radio.groupValue, "bar");
    expect(radio.autofocus, true);
    expect(radio.materialTapTargetSize, MaterialTapTargetSize.padded);
    expect(radio.toggleable, false);
    expect(radio.style!.activeColor, Colors.black);
    expect(radio.style!.focusColor, Colors.black);
    expect(radio.style!.hoverColor, Colors.black);
    expect(radio.style!.splashRadius, 2);
    expect(radio.style!.visualDensity, VisualDensity.comfortable);
  });

  testWidgets('LenraRadio onPressed', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();
    var eventsNb = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (Event e) {
            expect(e.code, "pressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "radio",
        "value": true,
        "groupValue": "a",
        "onPressed": {"code": "pressed"},
      }
    };

    uiStream.add(ui);
    await tester.pump();
    LenraRadio<String> tmp = LenraRadio<String>(
      value: "foo",
      groupValue: "bar",
      onPressed: null,
    );

    var finderRadio = find.byType(tmp.runtimeType);
    expect(finderRadio, findsOneWidget);
    await tester.tap(finderRadio);
    expect(eventsNb, 1);
  });
}
