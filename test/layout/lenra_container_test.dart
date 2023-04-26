import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraContainer test', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "container",
            "child": {
              "type": "text",
              "value": "foo",
            },
            "padding": {
              "top": 2.0,
              "bottom": 2.0,
              "right": 2.0,
              "left": 2.0,
            },
            "decoration": {
              "color": 0xFFFFFFFF,
            },
            "constraints": {
              "minWidth": 1.0,
              "maxHeight": 1.0,
              "minHeight": 1.0,
              "maxWidth": 1.0,
            }
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var finderContainer = find.byType(LenraContainer);
    LenraContainer container = tester.widget<LenraContainer>(finderContainer);
    expect(finderContainer, findsOneWidget);
    expect(container.padding!.horizontal, 4);
    expect(container.decoration!.color, Colors.white);
    expect(container.constraints!.minWidth, 1.0);
  });

  testWidgets('LenraContainer test constraints', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "container",
            "child": {
              "type": "text",
              "value": "foo",
            },
            "constraints": {
              "minHeight": 5.0,
              "maxHeight": 5.0,
              "minWidth": 5.0,
              "maxWidth": 5.0,
            }
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var finderContainer = find.byType(LenraContainer);
    LenraContainer container = tester.widget<LenraContainer>(finderContainer);
    expect(finderContainer, findsOneWidget);
    expect(container.constraints!.minWidth, 5);
    expect(container.constraints!.maxWidth, 5);
    expect(container.constraints!.minHeight, 5);
    expect(container.constraints!.maxHeight, 5);
  });

  testWidgets('LenraContainer test decoration and border', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "type": "container",
            "child": {
              "type": "text",
              "value": "foo",
            },
            "border": {
              "top": {"width": 2.0, "color": 0xFFFFFFFF},
              "left": {"width": 2.0, "color": 0xFFFFFFFF},
              "right": {"width": 2.0, "color": 0xFFFFFFFF},
              "bottom": {"width": 2.0, "color": 0xFFFFFFFF},
            },
            "decoration": {"color": 0xFFFFFFFF},
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    LenraContainer container = tester.widget<LenraContainer>(find.byType(LenraContainer));
    BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.white);
    expect(container.border!.bottom.width, 2.0);
    expect(container.border!.top.color, Colors.white);
  });
}
