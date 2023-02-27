// import 'package:flutter/widgets.dart';
// import 'package:lenra_components/component/lenra_text.dart';
// import 'package:lenra_ui_runner/widget_model.dart';
// import 'package:provider/src/provider.dart';
// import "../test_helper.dart";
// import 'package:flutter_test/flutter_test.dart';
// import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
//   testWidgets('LenraStack should properly build children.', (WidgetTester tester) async {
//     BuildContext? _context;

//     await tester.pumpWidget(
//       createBaseTestWidgets(
//         child: Builder(
//           builder: (BuildContext context) {
//             _context = context;

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
//         "type": "stack",
//         "children": [
//           {"type": "text", "value": "foo"},
//           {"type": "text", "value": "bar"}
//         ],
//       }
//     };

//     _context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();
//     expect(find.byType(LenraText), findsNWidgets(2));
//     expect(find.text("foo"), findsOneWidget);
//     expect(find.text("bar"), findsOneWidget);

//     expect(tester.getTopLeft(find.text("foo")), tester.getTopLeft(find.text("bar")));
//   });

//   testWidgets('LenraStack alignment.', (WidgetTester tester) async {
//     BuildContext? _context;

//     await tester.pumpWidget(
//       createBaseTestWidgets(
//         child: Builder(
//           builder: (BuildContext context) {
//             _context = context;

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
//         "type": "stack",
//         "alignment": "topRight",
//         "children": [
//           {"type": "text", "value": "loremipsum"},
//           {"type": "text", "value": "bar"}
//         ],
//       }
//     };

//     _context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();

//     expect(tester.getTopLeft(find.text("loremipsum")) == tester.getTopLeft(find.text("bar")), false);
//     expect(tester.getTopRight(find.text("loremipsum")), tester.getTopRight(find.text("bar")));
//   });

//   testWidgets('LenraStack fit expand.', (WidgetTester tester) async {
//     BuildContext? _context;

//     await tester.pumpWidget(
//       createBaseTestWidgets(
//         child: Builder(
//           builder: (BuildContext context) {
//             _context = context;

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
//         "type": "stack",
//         "fit": "expand",
//         "children": [
//           {"type": "text", "value": "loremipsum"},
//           {"type": "text", "value": "bar"}
//         ],
//       }
//     };

//     _context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();

//     expect(tester.getSize(find.text("loremipsum")), tester.getSize(find.text("bar")));
//   });

//   testWidgets('LenraStack basic fit.', (WidgetTester tester) async {
//     BuildContext? _context;

//     await tester.pumpWidget(
//       createBaseTestWidgets(
//         child: Builder(
//           builder: (BuildContext context) {
//             _context = context;

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
//         "type": "stack",
//         "children": [
//           {"type": "text", "value": "loremipsum"},
//           {"type": "text", "value": "bar"}
//         ],
//       }
//     };

//     _context!.read<ViewModel>().replaceUi(ui);

//     await tester.pump();

//     expect(tester.getSize(find.text("loremipsum")) == tester.getSize(find.text("bar")), false);
//   });
}
