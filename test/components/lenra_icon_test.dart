import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import 'package:provider/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraIcon test properties', (WidgetTester tester) async {
    LenraWidget widget = LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: {
        "root": {
          "type": "icon",
          "value": "fingerprint",
          "size": 6,
          "color": 0xFF000000,
          "semanticLabel": "foo",
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
    var finderIcon = find.byType(LenraIcon);
    var icon = tester.widget<LenraIcon>(finderIcon);
    expect(finderIcon, findsOneWidget);
    expect(icon.value, Icons.fingerprint);
    expect(icon.color, Colors.black);
    expect(icon.size, 6);
    expect(icon.semanticLabel, "foo");
  });
}
