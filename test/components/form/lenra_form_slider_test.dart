import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_slider.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'LenraForm Slider should work properly when pressed',
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
                    "_type": "slider",
                    "value": 0.0,
                    "max": 1.0,
                    "min": 0.0,
                    "name": "sliderValue",
                    "onChanged": {"code": "changed"}
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
                "sliderValue": 0.5,
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraSlider));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Slider should work properly when pressed without onPressed property',
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
                    "_type": "slider",
                    "value": 0.0,
                    "max": 1.0,
                    "min": 0.0,
                    "name": "sliderValue",
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
                "sliderValue": 0.5,
              });
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraSlider));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets('LenraForm Slider should not update form value when `name` property is not set',
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
                  "_type": "slider",
                  "value": 0.0,
                  "max": 1.0,
                  "min": 0.0,
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
    await tester.tap(find.byType(LenraSlider));
    await tester.tap(find.byType(LenraButton));
    expect(hasBeenNotified, true);
  });

  testWidgets(
    'LenraForm Slider should not crash when `name` property is set outside of a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "_type": "flex",
              "children": [
                {
                  "_type": "slider",
                  "value": 0.0,
                  "max": 1.0,
                  "min": 0.0,
                  "name": "sliderValue",
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
      await tester.tap(find.byType(LenraSlider));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, false);
    },
  );

  testWidgets(
    'LenraForm Slider sends default value to form when not clicked',
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
                    "_type": "slider",
                    "value": 0.0,
                    "max": 1.0,
                    "min": 0.0,
                    "name": "sliderValue",
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
                "sliderValue": 0.0,
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
    'LenraForm Slider properly executes listener when inside a Form',
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
                    "_type": "slider",
                    "value": 0.0,
                    "max": 1.0,
                    "min": 0.0,
                    "name": "sliderValue",
                    "onChanged": {"code": "changed"}
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
                "sliderValue": 0.5,
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
      await tester.tap(find.byType(LenraSlider));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasEnteredListener, true);
    },
  );
}
