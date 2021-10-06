import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';

import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('check size lenraButton properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "button",
        "text": "foo",
        "size": "small",
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var button = find.byType(LenraButton);
    expect(find.byType(LenraButton), findsOneWidget);
    expect(tester.widget<LenraButton>(button).size, LenraComponentSize.small);
  });
}
