import 'package:flutter/widgets.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/src/provider.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('check text properties', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
          },
        ),
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

    _context!.read<ViewModel>().replaceUi(ui);

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
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "text",
        "value": "Test",
        "children": [
          {
            "type": "text",
            "value": "Foo",
            "children": [
              {"type": "text", "value": "Baz"}
            ]
          },
          {"type": "text", "value": "Bar"}
        ]
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();
    expect(find.text("TestFooBazBar"), findsOneWidget);
  });
}
