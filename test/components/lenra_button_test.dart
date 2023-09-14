import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('LenraButton should work properly', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "button",
            "text": "foo",
            "onPressed": {"code": "pressed"}
          }
        },
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
