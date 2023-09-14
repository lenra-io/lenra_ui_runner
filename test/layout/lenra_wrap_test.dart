import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraWrap test default value', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "wrap",
            "children": [
              {"_type": "text", "value": "foo"},
              {"_type": "text", "value": "bar"},
              {"_type": "text", "value": "test"},
              {"_type": "text", "value": "lorem"},
              {"_type": "text", "value": "ipsum"}
            ]
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    var finderWrap = find.byType(LenraWrap);
    LenraWrap wrap = tester.widget<LenraWrap>(finderWrap);
    expect(wrap.children.length, 5);
    expect(wrap.direction, Axis.horizontal);
    expect(wrap.crossAxisAlignment, WrapCrossAlignment.start);
    expect(wrap.runAlignment, WrapAlignment.start);
    expect(wrap.alignment, WrapAlignment.start);
    expect(wrap.spacing, 0);
    expect(wrap.runSpacing, 0);
    expect(wrap.verticalDirection, VerticalDirection.down);
    expect(wrap.horizontalDirection, null);
  });

  testWidgets('LenraWrap test value', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "wrap",
            "direction": "vertical",
            "crossAxisAlignment": "end",
            "runAlignment": "end",
            "alignment": "end",
            "spacing": 2.0,
            "runSpacing": 2.0,
            "verticalDirection": "up",
            "horizontalDirection": "rtl",
            "children": [
              {"_type": "text", "value": "foo"},
              {"_type": "text", "value": "bar"},
              {"_type": "text", "value": "test"},
            ]
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    var finderWrap = find.byType(LenraWrap);
    LenraWrap wrap = tester.widget<LenraWrap>(finderWrap);
    expect(wrap.children.length, 3);
    expect(wrap.direction, Axis.vertical);
    expect(wrap.crossAxisAlignment, WrapCrossAlignment.end);
    expect(wrap.runAlignment, WrapAlignment.end);
    expect(wrap.alignment, WrapAlignment.end);
    expect(wrap.spacing, 2.0);
    expect(wrap.runSpacing, 2.0);
    expect(wrap.verticalDirection, VerticalDirection.up);
    expect(wrap.horizontalDirection, TextDirection.rtl);
  });

  testWidgets('LenraWrap should properly wrap children', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "wrap",
            "spacing": 8000,
            "runSpacing": 16.0,
            "children": [
              {"_type": "text", "value": "foo"},
              {"_type": "text", "value": "bar"},
            ]
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.text("foo")), const Offset(0, 0));
    expect(tester.getTopLeft(find.text("bar")), const Offset(0, 30));
  });

  testWidgets('LenraWrap direction should work', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "wrap",
            "spacing": 1000,
            "runSpacing": 16.0,
            "direction": "vertical",
            "children": [
              {"_type": "text", "value": "foo"},
              {"_type": "text", "value": "bar"},
            ]
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.text("foo")), const Offset(0, 0));
    expect(tester.getTopLeft(find.text("bar")), const Offset(58, 0));
  });
}
