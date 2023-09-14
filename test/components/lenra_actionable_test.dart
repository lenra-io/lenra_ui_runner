import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_actionable.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  late int eventsNb;

  setUp(() {
    eventsNb = 0;
  });

  testWidgets('Check correctly built and listener working', (WidgetTester tester) async {
    eventsNb = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "actionable",
            "child": {
              "_type": "text",
              "value": "foo",
            },
            "onDoublePressed": {
              "code": "doublePressed",
            }
          }
        },
        sendEventFn: (_) {
          eventsNb += 1;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });

  testWidgets('onPressed working', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "actionable",
            "child": {
              "_type": "text",
              "value": "foo",
            },
            "onPressed": {
              "code": "pressed",
            }
          }
        },
        sendEventFn: (_) {
          eventsNb += 1;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    expect(eventsNb, 1);
  });

  testWidgets('onPressed does not conflict with onDoublePressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "actionable",
            "child": {
              "_type": "text",
              "value": "foo",
            },
            "onPressed": {
              "code": "pressed",
            },
            "onDoublePressed": {"code": "doublePressed"}
          }
        },
        sendEventFn: (_) {
          eventsNb += 1;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });

  testWidgets('onDoublePressed does not conflict with onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "actionable",
            "child": {
              "_type": "text",
              "value": "foo",
            },
            "onPressed": {
              "code": "pressed",
            },
            "onDoublePressed": {"code": "doublePressed"}
          }
        },
        sendEventFn: (_) {
          eventsNb += 1;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });
  testWidgets('Test default Color for the actionable', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "actionable",
            "child": {"_type": "text", "value": "Purple"}
          },
        },
        sendEventFn: (_) {
          eventsNb += 1;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var finder = find.descendant(
      of: find.byType(LenraApplicationActionable),
      matching: find.byType(Material),
    );
    expect((tester.widget(finder) as Material).color, Colors.transparent);
  });
}
