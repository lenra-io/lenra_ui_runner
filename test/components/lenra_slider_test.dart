import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/src/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraSlider test properties', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget();
          },
        ),
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

    _context!.read<WidgetModel>().replaceUi(ui);
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
    BuildContext? _context;
    bool hasBeenNotified = false;
    double value = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: Builder(
            builder: (BuildContext context) {
              _context = context;

              return LenraWidget();
            },
          ),
          onNotification: (Event e) {
            expect(e.code, "pressed");
            hasBeenNotified = true;
            value = e.data.toMap()["value"];
            return false;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "slider",
        "value": value,
        "min": 0,
        "max": 100,
        "divisions": 100,
        "onChanged": {"code": "pressed"}
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();
    var finderSlider = find.byType(LenraSlider);

    expect(finderSlider, findsOneWidget);
    await tester.tap(finderSlider);
    expect(hasBeenNotified, true);
    expect(value, 50);
  });
}
