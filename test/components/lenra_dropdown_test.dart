import 'package:lenra_components/component/lenra_dropdown_button.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test onPressed in a child dropdownButton', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "dropdownButton",
            "text": "foo",
            "child": {
              "_type": "button",
              "text": "bar",
              "onPressed": {"code": "yourCode"},
            }
          }
        },
        sendEventFn: (_) {
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var dropdownButton = find.byType(LenraDropdownButton);
    expect(find.byType(LenraDropdownButton), findsOneWidget);
    await tester.tap(dropdownButton);
    await tester.pump();
    var button = find.text("bar");
    await tester.tap(button);
    expect(hasBeenNotified, true);
  });
}
