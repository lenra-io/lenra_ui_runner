import 'package:flutter/widgets.dart';
import 'package:lenra_components/component/lenra_text.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check text properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "text",
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
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

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

  testWidgets('Test Text children', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "text",
            "value": "Test",
            "children": [
              {
                "_type": "text",
                "value": "Foo",
                "children": [
                  {"_type": "text", "value": "Baz"}
                ]
              },
              {"_type": "text", "value": "Bar"}
            ]
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    expect(find.text("TestFooBazBar"), findsOneWidget);
  });
}
