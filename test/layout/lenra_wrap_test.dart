import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_wrap.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraWrap test default value', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "wrap",
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"},
          {"type": "text", "value": "test"},
          {"type": "text", "value": "lorem"},
          {"type": "text", "value": "ipsum"}
        ]
      }
    };

    uiStream.add(ui);
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
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "wrap",
        "direction": "vertical",
        "crossAxisAlignment": "end",
        "runAlignment": "end",
        "alignment": "end",
        "spacing": 2.0,
        "runSpacing": 2.0,
        "verticalDirection": "up",
        "horizontalDirection": "rtl",
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"},
          {"type": "text", "value": "test"},
        ]
      }
    };

    uiStream.add(ui);
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
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "wrap",
        "spacing": 100.0,
        "runSpacing": 2.0,
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"},
        ]
      }
    };

    uiStream.add(ui);
    await tester.pump();

    expect(tester.getTopLeft(find.text("foo")), const Offset(0, 0));
    expect(tester.getTopLeft(find.text("bar")), const Offset(0, 30));
  });

  testWidgets('LenraWrap direction should work', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "wrap",
        "spacing": 75.0,
        "runSpacing": 2.0,
        "direction": "vertical",
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"},
        ]
      }
    };

    uiStream.add(ui);
    await tester.pump();

    expect(tester.getTopLeft(find.text("foo")), const Offset(0, 0));
    expect(tester.getTopLeft(find.text("bar")), const Offset(58, 0));
  });  
}