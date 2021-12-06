import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraSlider test properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "slider",
        "value": 10,
        "autofocus": true,
        "min": 0,
        "max": 100,
        "divisions": 100,
        "label": 12,
        "style": {"activeColor": 0xFF000000, "inactiveColor": 0xFF000000, "thumbColor": 0xFF000000},
        "onPressed": {"code": "pressed"}
      }
    };

    uiStream.add(ui);
    await tester.pump();

    var finderSlider = find.byType(LenraSlider);
    var slider = tester.widget<LenraSlider>(finderSlider);
    expect(finderSlider, findsOneWidget);
    expect(slider.value, 10.0);
    expect(slider.autofocus, true);
    expect(slider.min, 0.0);
    expect(slider.max, 100.0);
    expect(slider.divisions, 100.0);
    expect(slider.label, '12');
    expect(slider.style!.activeColor, Colors.black);
    expect(slider.style!.inactiveColor, Colors.black);
    expect(slider.style!.thumbColor, Colors.black);
  });

  testWidgets('LenraSlider test onChanged', (WidgetTester tester) async {
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
        "type": "slider",
        "value": 50,
        "min": 0,
        "max": 100,
        "divisions": 100,
        "onChanged": {"code": "pressed"}
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var finderSlider = find.byType(LenraSlider);
    Offset topLeft = tester.getTopLeft(finderSlider);
    Offset bottomRight = tester.getBottomRight(finderSlider);
    Offset target = topLeft + (bottomRight - topLeft);

    expect(finderSlider, findsOneWidget);
    await tester.drag(finderSlider, target);
    expect(hasBeenNotified, true);
  });
}
