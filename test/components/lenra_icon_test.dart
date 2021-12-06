import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraIcon test properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "icon",
        "value": "fingerprint",
        "size": 6,
        "color": 0xFF000000,
        "semanticLabel": "foo",
      }
    };

    uiStream.add(ui);
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
