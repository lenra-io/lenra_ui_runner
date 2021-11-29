import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:lenra_components/component/lenra_text.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('check text properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "text",
        "value": "foo",
        "spellOut": true,
        "style": {
          "fontSize": 2,
          "fontStyle": "italic",
        },
        "semanticsLabel": "bar",
        "locale": {
          "languageCode": "fr",
          "countryCode": "FR",
        },
      }
    };

    uiStream.add(ui);

    await tester.pump();

    var locale = const Locale('fr', 'FR');
    var text = find.byType(LenraText);
    var textWidget = tester.widget<LenraText>(text);
    expect(textWidget.text, "foo");
    expect(textWidget.spellOut, true);
    expect(textWidget.style!.fontSize, 2);
    expect(textWidget.style!.fontStyle, FontStyle.italic);
    expect(textWidget.semanticsLabel, "bar");
    expect(textWidget.locale, locale);
    expect(find.byType(LenraText), findsOneWidget);
  });

  // testWidgets('Test Text children', (WidgetTester tester) async {
  //   StreamController<Map<String, dynamic>> uiStream = StreamController();
  //   StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "text",
  //       "value": "Test",
  //       "children": [
  //         {
  //           "type": "text",
  //           "value": "Foo",
  //           "children": [
  //             {"type": "text", "value": "Baz"}
  //           ]
  //         },
  //         {"type": "text", "value": "Bar"}
  //       ]
  //     }
  //   };

  //   uiStream.add(ui);
  //   await tester.pump();
  //   expect(find.text("TestFooBazBar"), findsOneWidget);
  // });
}
