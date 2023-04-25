import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Test onPressed in a child dropdownButton', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    LenraWidget widget = LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: {
        "root": {
          "type": "dropdownButton",
          "text": "foo",
          "child": {
            "type": "button",
            "text": "bar",
            "onPressed": {"code": "yourCode"},
          }
        }
      },
    );

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: widget,
        sendEventFn: (_) {
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

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
