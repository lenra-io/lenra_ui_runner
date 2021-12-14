import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Basic LenraCheckbox should work properly', (WidgetTester tester) async {
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
        "type": "checkbox",
        "value": true,
        "onPressed": {"code": "check"}
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
  });

  testWidgets('LenraCheckbox onPressed should work properly', (WidgetTester tester) async {
    BuildContext? _context;
    bool hasBeenNotified = false;

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
            expect(e.code, "check");
            expect(e.data.toMap()["value"], false);
            hasBeenNotified = true;
            return false;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "checkbox",
        "value": true,
        "onPressed": {"code": "check"}
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
    await tester.tap(find.byType(LenraCheckbox));
    expect(hasBeenNotified, true);
  });
}
