import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('lenraMenuItem test all properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
          child: NotificationListener(
              child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
              onNotification: (Event e) {
                expect(e.code, "yourCode");
                hasBeenNotified = true;
                return false;
              })),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "menu",
        "children": [
          {
            "type": "menuItem",
            "text": "foo",
            "icon": "aod",
            "onPressed": {"code": "yourCode"}
          },
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var menuItem = find.byType(LenraMenuItem);
    expect(find.byType(LenraMenu), findsOneWidget);
    expect(find.byType(LenraMenuItem), findsOneWidget);
    expect(find.text("foo"), findsOneWidget);
    expect(find.byIcon(Icons.aod), findsOneWidget);
    await tester.tap(menuItem);
    expect(hasBeenNotified, true);
  });
}
