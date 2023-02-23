// import 'package:flutter/material.dart';
// import 'package:lenra_components/component/lenra_menu.dart';
// import 'package:lenra_ui_runner/models/channel_model.dart';
// import 'package:lenra_ui_runner/widget_model.dart';
// import 'package:provider/src/provider.dart';
// import '../mock_channel_model.dart';
// import "../test_helper.dart";
// import 'package:flutter_test/flutter_test.dart';
// import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
//   testWidgets('lenraMenuItem test all properties', (WidgetTester tester) async {
//     BuildContext? _context;
//     bool hasBeenNotified = false;

//     await tester.pumpWidget(
//       createBaseTestWidgets(
//         child: Builder(
//           builder: (BuildContext context) {
//             _context = context;
//             (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
//               hasBeenNotified = true;
//             });

//             return LenraWidget(
//               buildErrorPage: (_ctx, _e) => Text("error"),
//               showSnackBar: (_ctx, _e) => {},
//             );
//           },
//         ),
//       ),
//     );

//     Map<String, dynamic> ui = {
//       "root": {
//         "type": "menu",
//         "children": [
//           {
//             "type": "menuItem",
//             "text": "foo",
//             "icon": {"type": "icon", "value": "aod"},
//             "onPressed": {"code": "yourCode"}
//           },
//         ],
//       }
//     };

//     _context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();
//     var menuItem = find.byType(LenraMenuItem);
//     expect(find.byType(LenraMenu), findsOneWidget);
//     expect(find.byType(LenraMenuItem), findsOneWidget);
//     expect(find.text("foo"), findsOneWidget);
//     expect(find.byIcon(Icons.aod), findsOneWidget);
//     await tester.tap(menuItem);
//     expect(hasBeenNotified, true);
//   });
}
