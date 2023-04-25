import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('LenraButton should work properly', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    LenraWidget widget = LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: {
        "root": {
          "type": "button",
          "text": "foo",
          "onPressed": {"code": "pressed"}
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
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    expect(hasBeenNotified, true);
  });
}
