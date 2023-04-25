import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Basic LenraCheckbox should work properly', (WidgetTester tester) async {
    LenraWidget widget = LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: {
        "root": {
          "type": "checkbox",
          "value": true,
          "onPressed": {"code": "check"}
        }
      },
    );

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: widget,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
  });

  testWidgets('LenraCheckbox onPressed should work properly', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    LenraWidget widget = LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: {
        "root": {
          "type": "checkbox",
          "value": true,
          "onPressed": {"code": "check"}
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

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
    await tester.tap(find.byType(LenraCheckbox));
    expect(hasBeenNotified, true);
  });
}
