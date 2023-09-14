import 'package:lenra_components/component/lenra_text.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraStack should properly build children.', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "stack",
            "children": [
              {"_type": "text", "value": "foo"},
              {"_type": "text", "value": "bar"}
            ],
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    expect(find.byType(LenraText), findsNWidgets(2));
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);

    expect(tester.getTopLeft(find.text("foo")), tester.getTopLeft(find.text("bar")));
  });

  testWidgets('LenraStack alignment.', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "stack",
            "alignment": "topRight",
            "children": [
              {"_type": "text", "value": "loremipsum"},
              {"_type": "text", "value": "bar"}
            ],
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(tester.getTopLeft(find.text("loremipsum")) == tester.getTopLeft(find.text("bar")), false);
    expect(tester.getTopRight(find.text("loremipsum")), tester.getTopRight(find.text("bar")));
  });

  testWidgets('LenraStack fit expand.', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "stack",
            "fit": "expand",
            "children": [
              {"_type": "text", "value": "loremipsum"},
              {"_type": "text", "value": "bar"}
            ],
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(tester.getSize(find.text("loremipsum")), tester.getSize(find.text("bar")));
  });

  testWidgets('LenraStack basic fit.', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "stack",
            "children": [
              {"_type": "text", "value": "loremipsum"},
              {"_type": "text", "value": "bar"}
            ],
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    expect(tester.getSize(find.text("loremipsum")) == tester.getSize(find.text("bar")), false);
  });
}
