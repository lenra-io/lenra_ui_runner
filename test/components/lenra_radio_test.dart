import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/components/events/event.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  late StreamController<Map<String, dynamic>> uiStream;
  late StreamController<List<Map<String, dynamic>>> patchUiStream;
  late int eventsNb;

  setUp(() {
    uiStream = StreamController();
    patchUiStream = StreamController();
    eventsNb = 0;
  });

  testWidgets('Radio onpressed listener shoudl be working', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (Event e) {
            expect(e.code, "pressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "radio",
        "value": true,
        "onPressed": {
          "code": "pressed",
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.byType(LenraRadio), findsOneWidget);

    await tester.tap(find.byType(LenraRadio));
    expect(eventsNb, 1);
  });
}
