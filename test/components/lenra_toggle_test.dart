import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/src/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraToggle property', (WidgetTester tester) async {
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

    _context!.read<WidgetModel>().replaceUi(ui);
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
    BuildContext? _context;
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child:Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget();
          },
        ),onNotification: (Event e) {
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

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();

    var toggle = find.byType(LenraToggle);
    await tester.tap(toggle);
    await tester.pump();
    expect(hasBeenNotified, true);
  });
}
