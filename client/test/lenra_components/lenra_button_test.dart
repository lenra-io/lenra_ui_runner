import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/lenra_components/lenra_button.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

import '../page/lenra_page_test_help.dart';

void main() {
  test('lenra button test parameterized constructor', () {
    LenraButton lenraButton = LenraButton(
      disabled: true,
      text: "disabled",
      size: LenraComponentSize.Large,
      type: LenraButtonType.Secondary,
      leftIcon: null,
      rightIcon: null,
    );

    expect(lenraButton.disabled, true);
    expect(lenraButton.text, "disabled");
    expect(lenraButton.size, LenraComponentSize.Large);
    expect(lenraButton.type, LenraButtonType.Secondary);
    expect(lenraButton.leftIcon, null);
    expect(lenraButton.rightIcon, null);
  });
  testWidgets('Test LenraButton Medium size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.Medium,
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(32.0));
  });

  testWidgets('Test LenraButton Large size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.Large,
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(40.0));
  });

  testWidgets('Test LenraButton Small size', (WidgetTester tester) async {
    await tester.pumpWidget(createComponentTestWidgets(
      LenraButton(
        text: "Test",
        size: LenraComponentSize.Small,
      ),
    ));

    expect(tester.getSize(find.byType(LenraButton)).height, equals(24.0));
  });
}