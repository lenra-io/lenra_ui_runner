import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('lenraMenu should draw children correctly', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "menu",
        "children": [
          {"type": "menuItem", "text": "foo"},
          {"type": "menuItem", "text": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.byType(LenraMenu), findsOneWidget);
    expect(find.byType(LenraMenuItem), findsNWidgets(2));
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('lenraMenu should draw custom children correctly', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "menu",
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.byType(LenraMenu), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);
  });
}
