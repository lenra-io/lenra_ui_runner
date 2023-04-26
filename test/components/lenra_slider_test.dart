import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraSlider test properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
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
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

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
    bool hasBeenNotified = false;
    double value = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "slider",
            "value": value,
            "min": 0,
            "max": 100,
            "divisions": 100,
            "onChanged": {"code": "pressed"}
          }
        },
        sendEventFn: (event) {
          hasBeenNotified = true;
          value = event.data.toMap()["value"];
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var finderSlider = find.byType(LenraSlider);

    expect(finderSlider, findsOneWidget);
    await tester.tap(finderSlider);
    expect(hasBeenNotified, true);
    expect(value, 50);
  });
}
