// import 'package:flutter/material.dart';
// import 'package:lenra_components/component/lenra_button.dart';
// import 'package:lenra_components/component/lenra_slider.dart';
// import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
// import 'package:lenra_ui_runner/models/channel_model.dart';
// import 'package:lenra_ui_runner/widget_model.dart';
// import 'package:provider/provider.dart';
// import '../../mock_channel_model.dart';
// import '../../test_helper.dart';
// import 'package:flutter_test/flutter_test.dart';

// BuildContext? context;

// Widget createBaseFormTestWidget(Function callback) {
//   return createBaseTestWidgets(
//     child: Builder(
//       builder: (BuildContext ctx) {
//         context = ctx;
//         (Provider.of<ChannelModel>(ctx, listen: false) as MockChannelModel).setCallBack(callback);

//         return LenraWidget(
//           buildErrorPage: (_ctx, _e) => Text("error"),
//           showSnackBar: (_ctx, _e) => {},
//         );
//       },
//     ),
//   );
// }

// Map<String, dynamic> createBaseFormUi(List<Map<String, dynamic>> children) {
//   return {
//     "root": {
//       "type": "form",
//       "onSubmit": {"code": "submitted"},
//       "child": {"type": "flex", "children": children}
//     }
//   };
// }

void main() {
//   testWidgets(
//     'LenraForm Slider should work properly when pressed',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e["code"] == "submitted") {
//             expect(e["event"]["value"], {
//               "sliderValue": 0.5,
//             });
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi(
//         [
//           {
//             "type": "slider",
//             "value": 0.0,
//             "max": 1.0,
//             "min": 0.0,
//             "name": "sliderValue",
//             "onChanged": {"code": "changed"}
//           },
//           {
//             "type": "button",
//             "text": "Submit",
//             "submit": true,
//           },
//         ],
//       );

//       context!.read<ViewModel>().replaceUi(ui);

//       await tester.pump();
//       await tester.tap(find.byType(LenraSlider));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets(
//     'LenraForm Slider should work properly when pressed without onPressed property',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e["code"] == "submitted") {
//             expect(e["event"]["value"], {
//               "sliderValue": 0.5,
//             });
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi(
//         [
//           {
//             "type": "slider",
//             "value": 0.0,
//             "max": 1.0,
//             "min": 0.0,
//             "name": "sliderValue",
//           },
//           {
//             "type": "button",
//             "text": "Submit",
//             "submit": true,
//           },
//         ],
//       );

//       context!.read<ViewModel>().replaceUi(ui);

//       await tester.pump();
//       await tester.tap(find.byType(LenraSlider));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets('LenraForm Slider should not update form value when `name` property is not set',
//       (WidgetTester tester) async {
//     bool hasBeenNotified = false;

//     await tester.pumpWidget(
//       createBaseFormTestWidget((e) {
//         if (e["code"] == "submitted") {
//           // Expected value of Form should be empty
//           expect(e["event"]["value"], {});
//         }
//         hasBeenNotified = true;
//         return false;
//       }),
//     );

//     Map<String, dynamic> ui = createBaseFormUi([
//       {
//         "type": "slider",
//         "value": 0.0,
//         "max": 1.0,
//         "min": 0.0,
//       },
//       {
//         "type": "button",
//         "text": "Submit",
//         "submit": true,
//       }
//     ]);

//     context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();
//     await tester.tap(find.byType(LenraSlider));
//     await tester.tap(find.byType(LenraButton));
//     expect(hasBeenNotified, true);
//   });

//   testWidgets(
//     'LenraForm Slider should not crash when `name` property is set outside of a Form',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e["code"] == "submitted") {
//             expect(e["event"]["value"], {});
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = {
//         "root": {
//           "type": "flex",
//           "children": [
//             {
//               "type": "slider",
//               "value": 0.0,
//               "max": 1.0,
//               "min": 0.0,
//               "name": "sliderValue",
//             },
//             {
//               "type": "button",
//               "text": "Submit",
//               "submit": true,
//             }
//           ]
//         }
//       };

//       context!.read<ViewModel>().replaceUi(ui);

//       await tester.pump();
//       await tester.tap(find.byType(LenraSlider));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, false);
//     },
//   );

//   testWidgets(
//     'LenraForm Slider sends default value to form when not clicked',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e["code"] == "submitted") {
//             expect(e["event"]["value"], {
//               "sliderValue": 0.0,
//             });
//           }

//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi([
//         {
//           "type": "slider",
//           "value": 0.0,
//           "max": 1.0,
//           "min": 0.0,
//           "name": "sliderValue",
//         },
//         {
//           "type": "button",
//           "text": "Submit",
//           "submit": true,
//         }
//       ]);

//       context!.read<ViewModel>().replaceUi(ui);

//       await tester.pump();
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets(
//     'LenraForm Slider properly executes listener when inside a Form',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;
//       bool hasEnteredListener = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e["code"] == "submitted") {
//             expect(e["event"]["value"], {
//               "sliderValue": 0.5,
//             });
//           } else if (e["code"] == "changed") {
//             hasEnteredListener = true;
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi([
//         {
//           "type": "slider",
//           "value": 0.0,
//           "max": 1.0,
//           "min": 0.0,
//           "name": "sliderValue",
//           "onChanged": {"code": "changed"}
//         },
//         {
//           "type": "button",
//           "text": "Submit",
//           "submit": true,
//         }
//       ]);

//       context!.read<ViewModel>().replaceUi(ui);

//       await tester.pump();
//       await tester.tap(find.byType(LenraSlider));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//       expect(hasEnteredListener, true);
//     },
//   );
}
