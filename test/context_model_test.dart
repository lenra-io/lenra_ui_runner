import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Context model send JSON', (WidgetTester tester) async {
    late BuildContext contextLocal;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ContextModel>(create: (context) => ContextModel()),
        ],
        child: MaterialApp(
          home: LenraTheme(
            themeData: LenraThemeData(),
            child: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  contextLocal = context;

                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
    contextLocal.read<ContextModel>().mediaQueryData = MediaQuery.of(contextLocal);
    await tester.pump();
    var contextModel = contextLocal.read<ContextModel>();
    var contextJSON = contextModel.toJson();
    expect(contextJSON, {
      'screenSize': {'width': 800.0, 'height': 600.0}
    });
  });
}