import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('LenraImage errorBuilder should build error widget when an error occurs.', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createProviderImageWidget(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "image",
        "path": "abdcefg",
        "errorBuilder": {
          "type": "text",
          "value": "Error",
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Error"), findsOneWidget);
  });
}

Widget createProviderImageWidget({required Widget child}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LenraApplicationModel>(
        create: (context) => LenraApplicationModel('foo-url', "appName", ''),
      ),
    ],
    builder: (BuildContext context, _) => MaterialApp(
      home: LenraTheme(
        themeData: LenraThemeData(),
        child: Scaffold(
          body: child,
        ),
      ),
    ),
  );
}
