import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import '../mock_channel_model.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraButton should work properly', (WidgetTester tester) async {
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
        "type": "button",
        "text": "foo",
        "onPressed": {"code": "pressed"}
      }
    };

    _context!.read<ViewModel>().replaceUi(ui);

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    expect(hasBeenNotified, true);
  });
}
