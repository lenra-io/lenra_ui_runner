import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'LenraForm Checkbox should work properly when pressed',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "checkbox",
                    "value": true,
                    "name": "checkboxValue",
                    "onPressed": {"code": "checked"}
                  },
                  {
                    "_type": "button",
                    "text": "Submit",
                    "submit": true,
                  },
                ]
              }
            }
          },
          sendEventFn: (e) {
            if (e.code == "submitted") {
              expect(e.data.toMap()["value"], {
                "checkboxValue": false,
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

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
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "checkbox",
                    "value": true,
                    "name": "checkboxValue",
                  },
                  {
                    "_type": "button",
                    "text": "Submit",
                    "submit": true,
                  },
                ]
              }
            }
          },
          sendEventFn: (e) {
            if (e.code == "submitted") {
              expect(e.data.toMap()["value"], {
                "checkboxValue": false,
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets('LenraForm Checkbox should not update form value when `name` property is not set',
      (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "form",
            "onSubmit": {"code": "submitted"},
            "child": {
              "_type": "flex",
              "children": [
                {
                  "_type": "checkbox",
                  "value": true,
                  "onPressed": {"code": "checked"}
                },
                {
                  "_type": "button",
                  "text": "Submit",
                  "submit": true,
                }
              ]
            }
          }
        },
        sendEventFn: (e) {
          if (e.code == "submitted") {
            // Expected value of Form should be empty
            expect(e.data.toMap()["value"], {});
          }
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

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
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "flex",
              "children": [
                {
                  "_type": "checkbox",
                  "value": true,
                  "name": "checkboxValue",
                },
                {
                  "_type": "button",
                  "text": "Submit",
                  "submit": true,
                }
              ]
            }
          },
          sendEventFn: (e) {
            if (e.code == "submitted") {
              // Expected value of Form should be empty
              expect(e.data.toMap()["value"], {});
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, false);
    },
  );

  testWidgets(
    'LenraForm Checkbox sends default value to form when not clicked',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "checkbox",
                    "value": true,
                    "name": "checkboxValue",
                  },
                  {
                    "_type": "button",
                    "text": "Submit",
                    "submit": true,
                  }
                ]
              }
            }
          },
          sendEventFn: (e) {
            if (e.code == "submitted") {
              expect(e.data.toMap()["value"], {
                "checkboxValue": true,
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Checkbox properly executes listener when inside a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      bool hasEnteredListener = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "checkbox",
                    "value": true,
                    "name": "checkboxValue",
                    "onPressed": {"code": "checked"}
                  },
                  {
                    "_type": "button",
                    "text": "Submit",
                    "submit": true,
                  }
                ]
              }
            }
          },
          sendEventFn: (e) {
            if (e.code == "submitted") {
              expect(e.data.toMap()["value"], {
                "checkboxValue": false,
              });
            } else if (e.code == "checked") {
              hasEnteredListener = true;
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraCheckbox));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasEnteredListener, true);
    },
  );
}
