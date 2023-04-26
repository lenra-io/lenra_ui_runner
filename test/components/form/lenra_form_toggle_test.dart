// import 'package:flutter/material.dart';
// import 'package:lenra_components/component/lenra_button.dart';
// import 'package:lenra_components/component/lenra_toggle.dart';
// import 'package:lenra_ui_runner/io_components/lenra_widget.dart';
// import 'package:lenra_ui_runner/models/channel_model.dart';

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
//     'LenraForm Toggle should work properly when pressed',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e.code == "submitted") {
//             expect(e.data.toMap()["value"], {
//               "toggleValue": false,
//             });
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi(
//         [
//           {
//             "type": "toggle",
//             "value": true,
//             "name": "toggleValue",
//             "onPressed": {"code": "checked"}
//           },
//           {
//             "type": "button",
//             "text": "Submit",
//             "submit": true,
//           },
//         ],
//       );

//       

//       await tester.pump();
//       await tester.tap(find.byType(LenraToggle));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets(
//     'LenraForm toggle should work properly when pressed without onPressed property',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e.code == "submitted") {
//             expect(e.data.toMap()["value"], {
//               "toggleValue": false,
//             });
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi(
//         [
//           {
//             "type": "toggle",
//             "value": true,
//             "name": "toggleValue",
//           },
//           {
//             "type": "button",
//             "text": "Submit",
//             "submit": true,
//           },
//         ],
//       );

//       

//       await tester.pump();
//       await tester.tap(find.byType(LenraToggle));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets('LenraForm toggle should not update form value when `name` property is not set',
//       (WidgetTester tester) async {
//     bool hasBeenNotified = false;

//     await tester.pumpWidget(
//       createBaseFormTestWidget((e) {
//         if (e.code == "submitted") {
//           // Expected value of Form should be empty
//           expect(e.data.toMap()["value"], {});
//         }
//         hasBeenNotified = true;
//         return false;
//       }),
//     );

//     Map<String, dynamic> ui = createBaseFormUi([
//       {
//         "type": "toggle",
//         "value": true,
//         "onPressed": {"code": "checked"}
//       },
//       {
//         "type": "button",
//         "text": "Submit",
//         "submit": true,
//       }
//     ]);

//     

//     await tester.pump();
//     await tester.tap(find.byType(LenraToggle));
//     await tester.tap(find.byType(LenraButton));
//     expect(hasBeenNotified, true);
//   });

//   testWidgets(
//     'LenraForm toggle should not crash when `name` property is set outside of a Form',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e.code == "submitted") {
//             expect(e.data.toMap()["value"], {});
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
//               "type": "toggle",
//               "value": true,
//               "name": "toggleValue",
//             },
//             {
//               "type": "button",
//               "text": "Submit",
//               "submit": true,
//             }
//           ]
//         }
//       };

//       

//       await tester.pump();
//       await tester.tap(find.byType(LenraToggle));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, false);
//     },
//   );

//   testWidgets(
//     'LenraForm toggle sends default value to form when not clicked',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e.code == "submitted") {
//             expect(e.data.toMap()["value"], {
//               "toggleValue": true,
//             });
//           }

//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi([
//         {
//           "type": "toggle",
//           "value": true,
//           "name": "toggleValue",
//         },
//         {
//           "type": "button",
//           "text": "Submit",
//           "submit": true,
//         }
//       ]);

//       

//       await tester.pump();
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//     },
//   );

//   testWidgets(
//     'LenraForm toggle properly executes listener when inside a Form',
//     (WidgetTester tester) async {
//       bool hasBeenNotified = false;
//       bool hasEnteredListener = false;

//       await tester.pumpWidget(
//         createBaseFormTestWidget((e) {
//           if (e.code == "submitted") {
//             expect(e.data.toMap()["value"], {
//               "toggleValue": false,
//             });
//           } else if (e.code == "checked") {
//             hasEnteredListener = true;
//           }
//           hasBeenNotified = true;
//           return false;
//         }),
//       );

//       Map<String, dynamic> ui = createBaseFormUi([
//         {
//           "type": "toggle",
//           "value": true,
//           "name": "toggleValue",
//           "onPressed": {"code": "checked"}
//         },
//         {
//           "type": "button",
//           "text": "Submit",
//           "submit": true,
//         }
//       ]);

//       

//       await tester.pump();
//       await tester.tap(find.byType(LenraToggle));
//       await tester.tap(find.byType(LenraButton));
//       expect(hasBeenNotified, true);
//       expect(hasEnteredListener, true);
//     },
//   );
}
