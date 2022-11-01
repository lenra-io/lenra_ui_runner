import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/widget_model.dart';
import 'package:provider/provider.dart';
import '../mock_channel_model.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Basic LenraCheckbox should work properly', (WidgetTester tester) async {
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
        "type": "checkbox",
        "value": true,
        "onPressed": {"code": "check"}
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
  });

  testWidgets('LenraCheckbox onPressed should work properly', (WidgetTester tester) async {
    BuildContext? _context;
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;
            (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
              hasBeenNotified = true;
            });

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
        "type": "checkbox",
        "value": true,
        "onPressed": {"code": "check"}
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);
    await tester.pump();

    var checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(checkbox.value, true);
    await tester.tap(find.byType(LenraCheckbox));
    expect(hasBeenNotified, true);
  });
}
