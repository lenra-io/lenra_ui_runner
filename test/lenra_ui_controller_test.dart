import 'package:lenra_ui_runner/app.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:client_common/test/lenra_page_test_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraUiController simple instantiation', (WidgetTester tester) async {
    await tester.runAsync(
      () => tester.pumpWidget(
        createAppTestWidgets(
          const App(
            appName: "app-name",
            httpEndpoint: "http://localhost:4000",
            wsEndpoint: "http://localhost:4000",
            accessToken: "random-access-token",
          ),
        ),
      ),
    );

    expect(find.byType(LenraRoute), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // TODO : Fix this test to make sure that the lenra_ui_controller widget is working
  // testWidgets('LenraUiController with initialized ChannelModel',
  //     (WidgetTester tester) async {
  //   final GlobalKey key = GlobalKey();

  //   await tester.runAsync(
  //     () => tester.pumpWidget(
  //       createAppTestWidgets(
  //         LenraUiController(
  //           key: key,
  //           accessToken: "random-access-token",
  //           appName: "app-name",
  //         ),
  //       ),
  //     ),
  //   );

  //   await tester.pump();

  //   final context = tester.element(find.byType(Scaffold));
  //   context.read<ChannelModel>().channel!.send("ui", {"data": "data"});

  //   await tester.pump();

  //   expect(find.byType(LenraUiController), findsOneWidget);
  //   // expect(find.byType(LenraErrorPage), findsOneWidget);
  //   // expect(find.byType(LenraWidget<ApiErrors>), findsOneWidget);
  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });
}
