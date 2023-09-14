import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('change simple property', (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {
        "_type": "text",
        "value": "foo",
      }
    };

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    List<Map<String, dynamic>> patches = [
      {"path": "/root/value", "value": "bar", "op": "replace"}
    ];

    ui = JsonPatch.apply(ui, patches, strict: false);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    expect(find.text("foo"), findsNothing);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('Remove children of flex', (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {
        "_type": "flex",
        "children": [
          {"_type": "text", "value": "foo"}
        ]
      }
    };

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(find.byType(Text), findsOneWidget);

    List<Map<String, dynamic>> patches = [
      {"path": "/root/children/0", "op": "remove"}
    ];

    ui = JsonPatch.apply(ui, patches, strict: false);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Text), findsNothing);
  });

  testWidgets('Change children of flex', (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {
        "_type": "flex",
        "children": [
          {"_type": "text", "value": "foo"}
        ]
      }
    };

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    List<Map<String, dynamic>> patches = [
      {
        "path": "/root/children",
        "value": [
          {"_type": "text", "value": "bar"}
        ],
        "op": "replace"
      }
    ];

    ui = JsonPatch.apply(ui, patches, strict: false);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(find.text("foo"), findsNothing);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('Change children of flex', (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {"_type": "text", "value": "foo"}
    };

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    List<Map<String, dynamic>> patches = [
      {"path": "/root/_type", "value": "button", "op": "replace"},
      {"path": "/root/value", "op": "remove"},
      {"path": "/root/text", "value": "bar", "op": "add"}
    ];

    await tester.pump();

    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsNothing);

    ui = JsonPatch.apply(ui, patches, strict: false);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text("foo"), findsNothing);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('Change child of container', (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {
        "_type": "button",
        "text": "foo",
        "onPressed": {"code": "john"}
      }
    };

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    List<Map<String, dynamic>> patches = [
      {"op": "remove", "path": "/root/onPressed"},
      {"op": "remove", "path": "/root/text"},
      {"op": "replace", "path": "/root/_type", "value": "container"},
      {
        "op": "add",
        "path": "/root/child",
        "value": {
          "_type": "button",
          "text": "bar",
          "onPressed": {"code": "doe"}
        }
      }
    ];

    await tester.pump();

    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsNothing);

    ui = JsonPatch.apply(ui, patches, strict: false);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: ui,
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text("bar"), findsOneWidget);
    expect(find.text("foo"), findsNothing);
  });
}
