import 'package:flutter/widgets.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/widget_model.dart';

import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('check size lenraButton properties', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget();
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "button",
        "text": "foo",
        "size": "small",
      }
    };

    expect(find.byType(LenraButton), findsNothing);

    _context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();

    var button = find.byType(LenraButton);
    expect(find.byType(LenraButton), findsOneWidget);
    expect(tester.widget<LenraButton>(button).size, LenraComponentSize.small);
  });
}
