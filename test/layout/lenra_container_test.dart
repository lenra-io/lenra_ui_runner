import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraContainer test', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
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
    };

    uiStream.add(ui);
    await tester.pump();
    // debugDumpApp();
    var container = find.byType(LenraContainer);
    expect(container, findsOneWidget);
    expect(tester.widget<LenraContainer>(container).padding!.horizontal, 4);
    expect(tester.widget<LenraContainer>(container).decoration!.color, Colors.white);
    expect(tester.widget<LenraContainer>(container).constraints!.minWidth, 1.0);
  });

  testWidgets('LenraContainer test constraints', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
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
    };

    uiStream.add(ui);
    await tester.pump();
    var container = find.byType(LenraContainer);
    expect(container, findsOneWidget);
    expect(tester.widget<LenraContainer>(container).constraints!.minWidth, 5);
    expect(tester.widget<LenraContainer>(container).constraints!.maxWidth, 5);
    expect(tester.widget<LenraContainer>(container).constraints!.minHeight, 5);
    expect(tester.widget<LenraContainer>(container).constraints!.maxHeight, 5);
  });

  testWidgets('LenraContainer test decoration and border', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
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
    };

    uiStream.add(ui);
    await tester.pump();
    var container = find.byType(LenraContainer);
    BoxDecoration decoration = tester.widget<LenraContainer>(container).decoration as BoxDecoration;
    expect(decoration.color, Colors.white);
    expect(tester.widget<LenraContainer>(container).border!.bottom.width, 2.0);
    expect(tester.widget<LenraContainer>(container).border!.top.color, Colors.white);
  });
}
