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

BuildContext? context;

Widget createBaseFormTestWidget(bool Function(Event) onNotification) {
  return createBaseTestWidgets(
    child: NotificationListener(
      child: Builder(
        builder: (BuildContext ctx) {
          context = ctx;

          return LenraWidget(
            buildErrorPage: (_ctx, _e) => Text("error"),
            showSnackBar: (_ctx, _e) => {},
          );
        },
      ),
      onNotification: onNotification,
    ),
  );
}

Map<String, dynamic> createBaseFormUi(List<Map<String, dynamic>> children) {
  return {
    "root": {
      "type": "form",
      "onSubmit": {"code": "submitted"},
      "child": {"type": "flex", "children": children}
    }
  };
}

void main() {
  testWidgets(
    'LenraForm Checkbox should work properly when pressed',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "checkboxValue": false,
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "checkbox",
            "value": true,
            "name": "checkboxValue",
            "onPressed": {"code": "checked"}
          },
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Checkbox should work properly when pressed without onPressed property',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "checkboxValue": false,
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "checkbox",
            "value": true,
            "name": "checkboxValue",
          },
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets('LenraForm Checkbox should not work when `name` property is not set', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseFormTestWidget((e) {
        if (e.code == "submitted") {
          // Expected value of Form should be empty
          expect((e.data as ValueData).value, {});
        }
        hasBeenNotified = true;
        return false;
      }),
    );

    Map<String, dynamic> ui = createBaseFormUi([
      {
        "type": "checkbox",
        "value": true,
        "onPressed": {"code": "checked"}
      },
      {
        "type": "button",
        "text": "Submit",
        "submit": true,
      }
    ]);

    context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();
    await tester.tap(find.byType(LenraCheckbox));
    await tester.tap(find.byType(LenraButton));
    expect(hasBeenNotified, true);
  });

  testWidgets(
    'LenraForm Checkbox should not crash when `name` property is set outside of a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {});
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = {
        "root": {
          "type": "flex",
          "children": [
            {
              "type": "checkbox",
              "value": true,
              "name": "checkboxValue",
            },
            {
              "type": "button",
              "text": "Submit",
              "submit": true,
            }
          ]
        }
      };

      context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, false);
    },
  );
}
