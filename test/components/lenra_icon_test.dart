import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraIcon test properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "icon",
            "value": "fingerprint",
            "size": 6,
            "color": 0xFF000000,
            "semanticLabel": "foo",
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var finderIcon = find.byType(LenraIcon);
    var icon = tester.widget<LenraIcon>(finderIcon);
    expect(finderIcon, findsOneWidget);
    expect(icon.value, Icons.fingerprint);
    expect(icon.color, Colors.black);
    expect(icon.size, 6);
    expect(icon.semanticLabel, "foo");
  });
}
