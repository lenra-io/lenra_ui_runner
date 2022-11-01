import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_icon.dart';
import 'package:lenra_ui_runner/models/widget_model.dart';
import 'package:provider/provider.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraIcon test properties', (WidgetTester tester) async {
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
        "type": "icon",
        "value": "fingerprint",
        "size": 6,
        "color": 0xFF000000,
        "semanticLabel": "foo",
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();
    var finderIcon = find.byType(LenraIcon);
    var icon = tester.widget<LenraIcon>(finderIcon);
    expect(finderIcon, findsOneWidget);
    expect(icon.value, Icons.fingerprint);
    expect(icon.color, Colors.black);
    expect(icon.size, 6);
    expect(icon.semanticLabel, "foo");
  });
}
