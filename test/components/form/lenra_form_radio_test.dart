import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/component/lenra_radio.dart';
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
    'LenraForm Radio should work properly when pressed',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      String groupValue = "radio1";

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "radioPressed") {
            groupValue = (e.data as ValueData).value;
          } else if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "radioValue": "radio2",
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "radio",
            "value": "radio1",
            "groupValue": groupValue,
            "onPressed": {"code": "radioPressed"},
            "name": "radioValue"
          },
          {
            "type": "radio",
            "value": "radio2",
            "groupValue": groupValue,
            "onPressed": {"code": "radioPressed"},
            "name": "radioValue"
          },
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<WidgetModel>().replaceUi(ui);

      LenraRadio<String> radio = LenraRadio<String>(
        groupValue: "",
        value: "",
        onPressed: (s) {},
      );

      await tester.pump();
      await tester.tap(find.byType(radio.runtimeType).at(1));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Radio should work properly when pressed without onPressed property',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      String groupValue = "radio1";

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "radioValue": "radio2",
            });
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {"type": "radio", "value": "radio1", "groupValue": groupValue, "name": "radioValue"},
          {"type": "radio", "value": "radio2", "groupValue": groupValue, "name": "radioValue"},
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<WidgetModel>().replaceUi(ui);

      LenraRadio<String> radio = LenraRadio<String>(
        groupValue: "",
        value: "",
        onPressed: (s) {},
      );

      await tester.pump();
      await tester.tap(find.byType(radio.runtimeType).at(1));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Radio should not update form value when `name` property is not set',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      String groupValue = "radio1";

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "radioPressed") {
            groupValue = (e.data as ValueData).value;
          } else if (e.code == "submitted") {
            expect((e.data as ValueData).value, {});
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "radio",
            "value": "radio1",
            "groupValue": groupValue,
            "onPressed": {"code": "radioPressed"},
          },
          {
            "type": "radio",
            "value": "radio2",
            "groupValue": groupValue,
            "onPressed": {"code": "radioPressed"},
          },
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<WidgetModel>().replaceUi(ui);

      LenraRadio<String> radio = LenraRadio<String>(
        groupValue: "",
        value: "",
        onPressed: (s) {},
      );

      await tester.pump();
      await tester.tap(find.byType(radio.runtimeType).at(1));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Radio should not crash when `name` property is set outside of a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      String groupValue = "radio1";

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "radioPressed") {
            groupValue = (e.data as ValueData).value;
          } else if (e.code == "submitted") {
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
              "type": "radio",
              "value": "radio1",
              "groupValue": groupValue,
              "onPressed": {"code": "radioPressed"},
              "name": "radioValue",
            },
            {
              "type": "radio",
              "value": "radio2",
              "groupValue": groupValue,
              "onPressed": {"code": "radioPressed"},
              "name": "radioValue",
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

      LenraRadio<String> radio = LenraRadio<String>(
        groupValue: "",
        value: "",
        onPressed: (s) {},
      );

      await tester.pump();
      await tester.tap(find.byType(radio.runtimeType).at(1));
      await tester.tap(find.byType(LenraButton));
      expect(groupValue, "radio2");
      expect(hasBeenNotified, true);
    },
  );

  testWidgets(
    'LenraForm Radio sends default value to form when not clicked',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "radioValue": "radio1",
            });
          }

          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi([
        {
          "type": "radio",
          "value": "radio1",
          "groupValue": "radio1",
          "onPressed": {"code": "radioPressed"},
          "name": "radioValue",
        },
        {
          "type": "radio",
          "value": "radio2",
          "groupValue": "radio1",
          "onPressed": {"code": "radioPressed"},
          "name": "radioValue",
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
    'LenraForm Radio properly executes listener when inside a Form',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      bool hasEnteredListener = false;
      String groupValue = "radio1";

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e.code == "submitted") {
            expect((e.data as ValueData).value, {
              "radioValue": "radio2",
            });
          } else if (e.code == "radioPressed") {
            groupValue = (e.data as ValueData).value;
            hasEnteredListener = true;
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi([
        {
          "type": "radio",
          "value": "radio1",
          "groupValue": groupValue,
          "onPressed": {"code": "radioPressed"},
          "name": "radioValue",
        },
        {
          "type": "radio",
          "value": "radio2",
          "groupValue": groupValue,
          "onPressed": {"code": "radioPressed"},
          "name": "radioValue",
        },
        {
          "type": "button",
          "text": "Submit",
          "submit": true,
        }
      ]);

      context!.read<WidgetModel>().replaceUi(ui);

      LenraRadio<String> radio = LenraRadio<String>(
        groupValue: "",
        value: "",
        onPressed: (s) {},
      );

      await tester.pump();
      await tester.tap(find.byType(radio.runtimeType).at(1));
      await tester.tap(find.byType(LenraButton));
      expect(hasBeenNotified, true);
      expect(hasEnteredListener, true);
    },
  );
}
