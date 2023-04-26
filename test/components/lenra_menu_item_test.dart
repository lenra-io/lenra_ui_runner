import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('lenraMenuItem test all properties', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "menu",
            "children": [
              {
                "type": "menuItem",
                "text": "foo",
                "icon": {"type": "icon", "value": "aod"},
                "onPressed": {"code": "yourCode"}
              },
            ],
          }
        },
        sendEventFn: (_) {
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

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
