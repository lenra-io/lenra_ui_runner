import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:components/page/register_page.dart';
import 'package:components/register_page/register_form.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:models/auth_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('expect RegisterPage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        home: LenraTheme(
          themeData: LenraThemeData(),
          child: RegisterPage(),
        ),
      ),
    ));
    final finder = find.byType(RegisterForm);
    expect(finder, findsOneWidget);
  });
}
