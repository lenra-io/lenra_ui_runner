// import 'package:flutter/material.dart';
// import 'package:lenra_ui_runner/lenra_widget.dart';

// import 'package:provider/provider.dart';

// import "./test_helper.dart";
// import 'package:flutter_test/flutter_test.dart';

void main() {
  // testWidgets('change simple property', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget(
  //             buildErrorPage: (_ctx, _e) => Text("error"),
  //             showSnackBar: (_ctx, _e) => {},
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "text",
  //       "value": "foo",
  //     }
  //   };
  //   List<Map<String, dynamic>> patches = [
  //     {"path": "/root/value", "value": "bar", "op": "replace"}
  //   ];

  //   _context!.read<ViewModel>().replaceUi(ui);
  //   _context!.read<ViewModel>().patchUi(patches);

  //   await tester.pump();
  //   expect(find.text("foo"), findsNothing);
  //   expect(find.text("bar"), findsOneWidget);
  // });

  // testWidgets('Remove children of flex', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget(
  //             buildErrorPage: (_ctx, _e) => Text("error"),
  //             showSnackBar: (_ctx, _e) => {},
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "flex",
  //       "children": [
  //         {"type": "text", "value": "foo"}
  //       ]
  //     }
  //   };

  //   List<Map<String, dynamic>> patches = [
  //     {"path": "/root/children/0", "op": "remove"}
  //   ];

  //   _context!.read<ViewModel>().replaceUi(ui);
  //   await tester.pump();

  //   expect(find.byType(Text), findsOneWidget);

  //   _context!.read<ViewModel>().patchUi(patches);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(Text), findsNothing);
  // });

  // testWidgets('Change children of flex', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget(
  //             buildErrorPage: (_ctx, _e) => Text("error"),
  //             showSnackBar: (_ctx, _e) => {},
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "flex",
  //       "children": [
  //         {"type": "text", "value": "foo"}
  //       ]
  //     }
  //   };

  //   List<Map<String, dynamic>> patches = [
  //     {
  //       "path": "/root/children",
  //       "value": [
  //         {"type": "text", "value": "bar"}
  //       ],
  //       "op": "replace"
  //     }
  //   ];

  //   _context!.read<ViewModel>().replaceUi(ui);
  //   _context!.read<ViewModel>().patchUi(patches);
  //   await tester.pump();

  //   expect(find.text("foo"), findsNothing);
  //   expect(find.text("bar"), findsOneWidget);
  // });

  // testWidgets('Change children of flex', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget(
  //             buildErrorPage: (_ctx, _e) => Text("error"),
  //             showSnackBar: (_ctx, _e) => {},
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {"type": "text", "value": "foo"}
  //   };

  //   List<Map<String, dynamic>> patches = [
  //     {"path": "/root/type", "value": "button", "op": "replace"},
  //     {"path": "/root/value", "op": "remove"},
  //     {"path": "/root/text", "value": "bar", "op": "add"}
  //   ];

  //   _context!.read<ViewModel>().replaceUi(ui);
  //   await tester.pump();

  //   expect(find.text("foo"), findsOneWidget);
  //   expect(find.text("bar"), findsNothing);

  //   _context!.read<ViewModel>().patchUi(patches);
  //   await tester.pump();
  //   await tester.pump();

  //   expect(find.text("foo"), findsNothing);
  //   expect(find.text("bar"), findsOneWidget);
  // });

  // testWidgets('Change child of container', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget(
  //             buildErrorPage: (_ctx, _e) => Text("error"),
  //             showSnackBar: (_ctx, _e) => {},
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "button",
  //       "text": "foo",
  //       "onPressed": {"code": "john"}
  //     }
  //   };

  //   List<Map<String, dynamic>> patches = [
  //     {"op": "remove", "path": "/root/onPressed"},
  //     {"op": "remove", "path": "/root/text"},
  //     {"op": "replace", "path": "/root/type", "value": "container"},
  //     {
  //       "op": "add",
  //       "path": "/root/child",
  //       "value": {
  //         "type": "button",
  //         "text": "bar",
  //         "onPressed": {"code": "doe"}
  //       }
  //     }
  //   ];

  //   _context!.read<ViewModel>().replaceUi(ui);
  //   await tester.pump();

  //   expect(find.text("foo"), findsOneWidget);
  //   expect(find.text("bar"), findsNothing);

  //   _context!.read<ViewModel>().patchUi(patches);
  //   await tester.pump();
  //   await tester.pump();

  //   expect(find.text("bar"), findsOneWidget);
  //   expect(find.text("foo"), findsNothing);
  // });
}