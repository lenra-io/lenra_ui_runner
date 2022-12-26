import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import '../../mock_channel_model.dart';
import '../../test_helper.dart';
import 'package:flutter_test/flutter_test.dart';

BuildContext? context;

Widget createBaseFormTestWidget(Function callback) {
  return createBaseTestWidgets(
    child: Builder(
      builder: (BuildContext ctx) {
        context = ctx;
        (Provider.of<ChannelModel>(ctx, listen: false) as MockChannelModel).setCallBack(callback);

        return LenraWidget(
          buildErrorPage: (_ctx, _e) => Text("error"),
          showSnackBar: (_ctx, _e) => {},
        );
      },
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
    'LenraForm Button should submit form properly when pressed',
    (WidgetTester tester) async {
      bool hasBeenNotified = false;
      bool hasSubmittedForm = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((event) {
          if (event["code"] == "submitted") {
            expect(event["event"]["value"], {});
            hasSubmittedForm = true;
          }
          hasBeenNotified = true;
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
          },
        ],
      );

      context!.read<ViewModel>().replaceUi(ui);

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
        createBaseFormTestWidget((e) => false),
      );

      Map<String, dynamic> ui = {
        "root": {
          "type": "button",
          "text": "Submit",
          "submit": true,
        }
      };

      context!.read<ViewModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
    },
  );

  testWidgets(
    'LenraForm Button should not submit form if submit property is false inside of a Form',
    (WidgetTester tester) async {
      bool hasSubmittedForm = false;

      await tester.pumpWidget(
        createBaseFormTestWidget((e) {
          if (e["code"] == "submitted") {
            hasSubmittedForm = true;
          }
          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "button",
            "text": "Submit",
          },
        ],
      );

      context!.read<ViewModel>().replaceUi(ui);

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
        createBaseFormTestWidget((e) {
          if (e["code"] == "submitted") {
            hasSubmittedForm = true;
          } else if (e["code"] == "pressed") {
            buttonPressed = true;
          }

          return false;
        }),
      );

      Map<String, dynamic> ui = createBaseFormUi(
        [
          {
            "type": "button",
            "text": "Submit",
            "submit": true,
            "onPressed": {"code": "pressed"}
          },
        ],
      );

      context!.read<ViewModel>().replaceUi(ui);

      await tester.pump();
      await tester.tap(find.byType(LenraButton));
      expect(hasSubmittedForm, true);
      expect(buttonPressed, true);
    },
  );
}
