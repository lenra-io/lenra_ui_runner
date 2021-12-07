import 'dart:async';
import 'package:lenra_components/component/lenra_text.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraStack should properly build children.', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "stack",
        "children": [
          {"type": "text", "value": "foo"},
          {"type": "text", "value": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.byType(LenraText), findsNWidgets(2));
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);

    expect(tester.getTopLeft(find.text("foo")), tester.getTopLeft(find.text("bar")));
  });

  testWidgets('LenraStack alignment.', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "stack",
        "alignment": "topRight",
        "children": [
          {"type": "text", "value": "loremipsum"},
          {"type": "text", "value": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();

    expect(tester.getTopLeft(find.text("loremipsum")) == tester.getTopLeft(find.text("bar")), false);
    expect(tester.getTopRight(find.text("loremipsum")), tester.getTopRight(find.text("bar")));
  });

  testWidgets('LenraStack fit expand.', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "stack",
        "fit": "expand",
        "children": [
          {"type": "text", "value": "loremipsum"},
          {"type": "text", "value": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();

    expect(tester.getSize(find.text("loremipsum")), tester.getSize(find.text("bar")));
  });

  testWidgets('LenraStack basic fit.', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "stack",
        "children": [
          {"type": "text", "value": "loremipsum"},
          {"type": "text", "value": "bar"}
        ],
      }
    };

    uiStream.add(ui);

    await tester.pump();

    expect(tester.getSize(find.text("loremipsum")) == tester.getSize(find.text("bar")), false);
  });
}