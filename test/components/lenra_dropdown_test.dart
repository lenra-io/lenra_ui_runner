import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Test onPressed in a child dropdownButton', (WidgetTester tester) async {
    BuildContext? _context;
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      NotificationListener(
        child: createBaseTestWidgets(
          child: Builder(
            builder: (BuildContext context) {
              _context = context;

              return LenraWidget();
            },
          ),
        ),
        onNotification: (Event e) {
          expect(e.code, "yourCode");
          hasBeenNotified = true;
          return false;
        },
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "dropdownButton",
        "text": "foo",
        "child": {
          "type": "button",
          "text": "bar",
          "onPressed": {"code": "yourCode"},
        }
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);

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
