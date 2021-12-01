import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';

import 'package:lenra_ui_runner/components/events/on_pressed_toggle_event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraToggle property', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "toggle",
        "value": true,
        "onPressed": {"code": "YourCode"},
        "style": {
          "activeTrackColor": 0xFF000000,
          "focusColor": 0xFF000000,
          "inactiveThumbColor": 0xFF000000,
          "hoverColor": 0xFF000000,
          "materialTapTargetSize": "padded",
        },
        "autofocus": true,
        "splashRadius": 2.0,
        "dragStartBehavior": "down",
      }
    };

    uiStream.add(ui);
    await tester.pump();

    var finderToggle = find.byType(LenraToggle);
    var toggle = tester.widget<LenraToggle>(finderToggle);
    var style = toggle.style;
    expect(finderToggle, findsOneWidget);
    expect(toggle.value, true);
    expect(toggle.autofocus, true);
    expect(toggle.splashRadius, 2.0);
    expect(toggle.dragStartBehavior, DragStartBehavior.down);
    expect(style!.activeTrackColor, Colors.black);
    expect(style.focusColor, Colors.black);
    expect(style.inactiveThumbColor, Colors.black);
    expect(style.hoverColor, Colors.black);
    expect(style.materialTapTargetSize, MaterialTapTargetSize.padded);
  });

  testWidgets('LenraToggle test onPressed', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (OnPressedToggleEvent e) {
            expect(e.code, "YourCode");
            hasBeenNotified = true;
            return false;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "toggle",
        "value": true,
        "onPressed": {"code": "YourCode"},
        "autofocus": true,
        "splashRadius": 2.0,
        "dragStartBehavior": "down",
      }
    };

    uiStream.add(ui);
    await tester.pump();

    var toggle = find.byType(LenraToggle);
    await tester.tap(toggle);
    await tester.pump();
    expect(hasBeenNotified, true);
  });
}
