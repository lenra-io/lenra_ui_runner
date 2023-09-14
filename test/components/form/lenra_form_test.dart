import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraForm should work properly', (WidgetTester tester) async {
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
                  "_type": "toggle",
                  "name": "toggleValue",
                  "value": true,
                  "onPressed": {"code": "toggled"}
                },
                {
                  "_type": "checkbox",
                  "value": true,
                  "name": "checkboxValue",
                  "onPressed": {"code": "checked"}
                },
                {
                  "_type": "radio",
                  "groupValue": "radioValue",
                  "value": "radioValue",
                  "name": "radio",
                },
                {
                  "_type": "radio",
                  "groupValue": "radioValue",
                  "value": "radioValue2",
                  "name": "radio",
                },
                {
                  "_type": "container",
                  "constraints": {"maxWidth": 400, "maxHeight": 100},
                  "child": {"_type": "textfield", "value": "textfieldValue", "name": "textfield"},
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
            expect(e.data.toMap()["value"],
                {"toggleValue": false, "checkboxValue": false, "radio": "radioValue", "textfield": "textfieldValue"});
          }
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(LenraToggle));
    await tester.tap(find.byType(LenraCheckbox));
    await tester.tap(find.byType(TextButton));
    expect(hasBeenNotified, true);
  });

  testWidgets('Nested LenraForm should work properly', (WidgetTester tester) async {
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
                  "_type": "form",
                  "onSubmit": {"code": "nestedSubmit"},
                  "child": {
                    "_type": "flex",
                    "children": [
                      {
                        "_type": "checkbox",
                        "value": true,
                        "name": "checkboxValue2",
                      },
                      {
                        "_type": "button",
                        "text": "Submit",
                        "submit": true,
                      }
                    ]
                  }
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
            expect(e.data.toMap()["value"], {"checkboxValue": false});
          } else if (e.code == "nestedSubmit") {
            expect(e.data.toMap()["value"], {"checkboxValue2": false});
          }
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(LenraCheckbox).at(0));
    // When switching the places of the following two lines the test fails.
    // If we find a problem in the future it might come from here.
    await tester.tap(find.byType(LenraCheckbox).at(1));
    await tester.tap(find.byType(TextButton).at(0));
    await tester.tap(find.byType(TextButton).at(1));
    expect(hasBeenNotified, true);
  });
}
