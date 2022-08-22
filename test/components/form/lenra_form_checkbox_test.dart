import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraForm should work properly', (WidgetTester tester) async {
    BuildContext? _context;
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: Builder(
            builder: (BuildContext context) {
              _context = context;

              return LenraWidget(
                buildErrorPage: (_ctx, _e) => Text("error"),
                showSnackBar: (_ctx, _e) => {},
              );
            },
          ),
          onNotification: (Event e) {
            if (e.code == "submitted") {
              expect((e.data as ValueData).value, {
                "checkboxValue": false,
                "checkboxValue2": false,
              });
            }
            hasBeenNotified = true;
            return false;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "form",
        "onSubmit": {"code": "submitted"},
        "child": {
          "type": "flex",
          "children": [
            {
              "type": "checkbox",
              "value": true,
              "name": "checkboxValue",
              "onPressed": {"code": "checked"}
            },
            {
              "type": "checkbox",
              "value": true,
              "onPressed": {"code": "checked2"}
            },
            {
              "type": "checkbox",
              "value": true,
              "name": "checkboxValue2",
            },
            {
              "type": "button",
              "text": "Submit",
              "submit": true,
            }
          ]
        }
      }
    };

    _context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();
    await tester.tap(find.byType(LenraCheckbox).at(0));
    await tester.tap(find.byType(LenraCheckbox).at(1));
    await tester.tap(find.byType(LenraCheckbox).at(2));
    await tester.tap(find.byType(LenraButton));
    expect(hasBeenNotified, true);
  });
}
