import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import '../mock_channel_model.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('Test onPressed in a child dropdownButton', (WidgetTester tester) async {
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
        "type": "dropdownButton",
        "text": "foo",
        "child": {
          "type": "button",
          "text": "bar",
          "onPressed": {"code": "yourCode"},
        }
      }
    };

    _context!.read<ViewModel>().replaceUi(ui);

    await tester.pump();
    var dropdownButton = find.byType(LenraDropdownButton);
    expect(find.byType(LenraDropdownButton), findsOneWidget);
    await tester.tap(dropdownButton);
    await tester.pump();
    var button = find.text("bar");
    await tester.tap(button);
    expect(hasBeenNotified, true);
  });
}
