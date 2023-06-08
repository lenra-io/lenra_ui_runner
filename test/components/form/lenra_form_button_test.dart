import 'package:lenra_components/component/lenra_button.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'LenraForm Button should submit form properly when pressed',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      bool hasSubmittedForm = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "type": "flex",
                "children": [
                  {
                    "type": "button",
                    "text": "Submit",
                    "submit": true,
                  },
                ]
              }
            }
          },
          sendEventFn: (event) {
            if (event.code == "submitted") {
              expect(event.data.toMap()["value"], {});
              hasSubmittedForm = true;
            }
            hasBeenNotified = true;
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasSubmittedForm, true);
    },
  );

  testWidgets(
    'LenraForm Button should not crash if submit property is true outside of a form',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "type": "button",
              "text": "Submit",
              "submit": true,
            }
          },
          sendEventFn: (_) {
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
    },
  );

  testWidgets(
    'LenraForm Button should not submit form if submit property is false inside of a Form',
    (WidgetTester tester) async {
      bool hasSubmittedForm = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "type": "flex",
                "children": [
                  {
                    "type": "button",
                    "text": "Submit",
                  },
                ]
              }
            }
          },
          sendEventFn: (event) {
            if (event.code == "submitted") {
              hasSubmittedForm = true;
            }
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasSubmittedForm, false);
    },
  );

  testWidgets(
    'LenraForm Button listener is properly triggered when set and when submit property is true in a Form',
    (WidgetTester tester) async {
      bool hasSubmittedForm = false;
      bool buttonPressed = false;

      await tester.pumpWidget(
        createBaseTestWidgets(
          ui: {
            "root": {
              "type": "form",
              "onSubmit": {"code": "submitted"},
              "child": {
                "type": "flex",
                "children": [
                  {
                    "type": "button",
                    "text": "Submit",
                    "submit": true,
                    "onPressed": {"code": "pressed"}
                  },
                ]
              }
            }
          },
          sendEventFn: (event) {
            if (event.code == "submitted") {
              hasSubmittedForm = true;
            } else if (event.code == "pressed") {
              buttonPressed = true;
            }
            return Future.value(true);
          },
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasSubmittedForm, true);
      expect(buttonPressed, true);
    },
  );
}
