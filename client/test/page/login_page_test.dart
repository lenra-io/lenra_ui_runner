import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:components/login_page/login_form.dart';
import 'package:components/page/login_page.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:models/auth_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('expect LoginPage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        home: LenraTheme(
          themeData: LenraThemeData(),
          child: LoginPage(),
        ),
      ),
    ));

    final finder = find.byType(LoginForm);
    expect(finder, findsOneWidget);
  });
}
