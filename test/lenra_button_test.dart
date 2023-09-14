import 'package:lenra_components/lenra_components.dart';
import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check size lenraButton properties', (WidgetTester tester) async {
    expect(find.byType(LenraButton), findsNothing);

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "button",
            "text": "foo",
            "size": "small",
          }
        },
        sendEventFn: (e) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();

    var button = find.byType(LenraButton);
    expect(find.byType(LenraButton), findsOneWidget);
    expect(tester.widget<LenraButton>(button).size, LenraComponentSize.small);
  });
}
