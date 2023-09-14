import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  testWidgets(
    'LenraForm Textfield should work properly when text is entered',
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
                    "_type": "container",
                    "constraints": {"maxWidth": 400, "maxHeight": 100},
                    "child": {
                      "_type": "textfield",
                      "value": "",
                      "name": "textfieldValue",
                      "onChanged": {"code": "changed"}
                    }
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
                "textfieldValue": "hi",
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

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
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "container",
                    "constraints": {"maxWidth": 400, "maxHeight": 100},
                    "child": {
                      "_type": "textfield",
                      "value": "",
                      "name": "textfieldValue",
                    }
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
                "textfieldValue": "hi",
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

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
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "form",
            "onSubmit": {"code": "submitted"},
            "child": {
              "_type": "flex",
              "children": [
                {
                  "_type": "container",
                  "constraints": {"maxWidth": 400, "maxHeight": 100},
                  "child": {
                    "_type": "textfield",
                    "value": "",
                    "onChanged": {"code": "changed"}
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
            // Expected value of Form should be empty
            expect(e.data.toMap()["value"], {});
          } else if (e.code == "changed") {
            expect(e.data.toMap()["value"], "hi");
          }
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

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
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "flex",
              "children": [
                {
                  "_type": "container",
                  "constraints": {"maxWidth": 400, "maxHeight": 100},
                  "child": {
                    "_type": "textfield",
                    "value": "",
                    "name": "textfieldValue",
                  }
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
              expect(e.data.toMap()["value"], {});
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

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
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "_type": "flex",
                "children": [
                  {
                    "_type": "container",
                    "constraints": {"maxWidth": 400, "maxHeight": 100},
                    "child": {
                      "_type": "textfield",
                      "value": "default",
                      "name": "textfieldValue",
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
              expect(e.data.toMap()["value"], {
                "textfieldValue": "default",
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
    'LenraForm TextField properly executes listener when inside a Form',
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
                    "_type": "container",
                    "constraints": {"maxWidth": 400, "maxHeight": 100},
                    "child": {
                      "_type": "textfield",
                      "value": "",
                      "name": "textfieldValue",
                      "onChanged": {"code": "changed"}
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
              expect(e.data.toMap()["value"], {
                "textfieldValue": "hi",
              });
            } else if (e.code == "changed") {
              hasEnteredListener = true;
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.enterText(find.byType(TextField), "hi");
      await tester.pump(Duration(milliseconds: 500));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasEnteredListener, true);
    },
  );
}
