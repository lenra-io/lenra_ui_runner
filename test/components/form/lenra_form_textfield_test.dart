import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
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
    'LenraForm Textfield should work properly when text is entered',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "textfieldValue": "hi",
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "container",
            "constraints": {"maxWidth": 400, "maxHeight": 100},
            "child": {
              "type": "textfield",
              "value": "",
              "name": "textfieldValue",
              "onChanged": {"code": "changed"}
            }
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
      await tester.enterText(find.byType(TextField), "hi");
      await tester.pump(Duration(milliseconds: 500));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm TextField should work properly when text is entered without onChanged property',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "textfieldValue": "hi",
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "container",
            "constraints": {"maxWidth": 400, "maxHeight": 100},
            "child": {
              "type": "textfield",
              "value": "",
              "name": "textfieldValue",
            }
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
      await tester.enterText(find.byType(TextField), "hi");
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets('LenraForm TextField should not update form value when `name` property is not set',
      (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseFormTestWidget((e) {
        if (e.code == "submitted") {
          // Expected value of Form should be empty
          expect((e.data as ValueData).value, {});
        } else if (e.code == "changed") {
          expect((e.data as ValueData).value, "hi");
        }
        hasBeenNotified = true;
        return false;
      }),
    );

    Map<String, dynamic> ui = createBaseFormUi([
      {
        "type": "container",
        "constraints": {"maxWidth": 400, "maxHeight": 100},
        "child": {
          "type": "textfield",
          "value": "",
          "onChanged": {"code": "changed"}
        }
      },
      {
        "type": "button",
        "text": "Submit",
        "submit": true,
      }
    ]);

    context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();
    await tester.enterText(find.byType(TextField), "hi");
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byType(LenraButton));
    expect(hasBeenNotified, true);
  });

  testWidgets(
    'LenraForm TextField should not crash when `name` property is set outside of a Form',
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
              "type": "container",
              "constraints": {"maxWidth": 400, "maxHeight": 100},
              "child": {
                "type": "textfield",
                "value": "",
                "name": "textfieldValue",
              }
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
      await tester.enterText(find.byType(TextField), "hi");
      await tester.pump(Duration(milliseconds: 500));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, false);
    },
  );

  testWidgets(
    'LenraForm TextField sends default value to form when no text is entered',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "textfieldValue": "default",
            });
          }

          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi([
        {
          "type": "container",
          "constraints": {"maxWidth": 400, "maxHeight": 100},
          "child": {
            "type": "textfield",
            "value": "default",
            "name": "textfieldValue",
          }
        },
        {
          "type": "button",
          "text": "Submit",
          "submit": true,
        }
      ]);

      context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm TextField properly executes listener when inside a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      bool hasEnteredListener = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "textfieldValue": "hi",
            });
          } else if (e.code == "changed") {
            hasEnteredListener = true;
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi([
        {
          "type": "container",
          "constraints": {"maxWidth": 400, "maxHeight": 100},
          "child": {
            "type": "textfield",
            "value": "",
            "name": "textfieldValue",
            "onChanged": {"code": "changed"}
          }
        },
        {
          "type": "button",
          "text": "Submit",
          "submit": true,
        }
      ]);

      context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      await tester.enterText(find.byType(TextField), "hi");
      await tester.pump(Duration(milliseconds: 500));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasEnteredListener, true);
    },
  );
}