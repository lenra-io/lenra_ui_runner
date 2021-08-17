import 'package:flutter_test/flutter_test.dart';
import 'package:components/page/verifiying_code_page.dart';
import 'package:components/verify_code_page/verify_code_form.dart';

import 'lenra_page_test_help.dart';

void main() {
  testWidgets('expect VerifyingCodePage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createAppTestWidgets(VerifyingCodePage()));
    final finder = find.byType(VerifyCodeForm);
    expect(finder, findsOneWidget);
  });
}
