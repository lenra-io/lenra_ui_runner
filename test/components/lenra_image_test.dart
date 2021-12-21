import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

void main() {
  // testWidgets('LenraImage errorBuilder should build error widget when an error occurs.', (WidgetTester tester) async {
  //   BuildContext? _context;

  //   await tester.pumpWidget(
  //     createBaseTestWidgets(
  //       child: Builder(
  //         builder: (BuildContext context) {
  //           _context = context;

  //           return LenraWidget();
  //         },
  //       ),
  //     ),
  //   );

  //   Map<String, dynamic> ui = {
  //     "root": {
  //       "type": "image",
  //       "path": "not-existing-path",
  //       "errorBuilder": {
  //         "type": "text",
  //         "value": "Error",
  //       }
  //     }
  //   };

  //   _context!.read<WidgetModel>().replaceUi(ui);

  //   await tester.pumpAndSettle();
  //   expect(find.text("Error"), findsOneWidget);
  // });

  final MockHttpClient client = MockHttpClient();
  final MockHttpClientRequest request = MockHttpClientRequest();
  final MockHttpClientResponse response = MockHttpClientResponse();
  final MockHttpHeaders headers = MockHttpHeaders();

  testWidgets('LenraImage loadingBuilder should build loader widget when the image is loading.',
      (WidgetTester tester) async {
    Map<String, dynamic> ui = {
      "root": {
        "type": "image",
        "fromNetwork": true,
        "path": "long-to-load-image",
        "loadingBuilder": {
          "type": "text",
          "value": "Loading",
        }
      }
    };

    HttpOverrides.runZoned(() async {
      BuildContext? _context;

      await tester.pumpWidget(
        createBaseTestWidgets(
          child: Builder(
            builder: (BuildContext context) {
              _context = context;

              return LenraWidget();
            },
          ),
        ),
      );

      _context!.read<WidgetModel>().replaceUi(ui);

      await tester.pump();
      expect(find.byType(LenraApplicationImage), findsOneWidget);
      expect(find.text("Loading"), findsOneWidget);
    }, createHttpClient: (_) {
      print("CREATE HTTP CLIENT");

      when(client.getUrl(Uri.parse("long-to-load-image"))).thenAnswer((_) {
        print("THEN ANSWER GETURL");
        print(Future<HttpClientRequest>.value(request));
        return Future<HttpClientRequest>.value(request);
      });
      when(request.headers).thenReturn(headers);
      when(request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
      when(response.contentLength).thenReturn(kTransparentImage.length);
      when(response.statusCode).thenReturn(HttpStatus.ok);
      when(response.listen(any)).thenAnswer((Invocation invocation) {
        final void Function(List<int>) onData = invocation.positionalArguments[0];
        final void Function() onDone = invocation.namedArguments[#onDone];
        final void Function(Object, [StackTrace]) onError = invocation.namedArguments[#onError];
        final bool cancelOnError = invocation.namedArguments[#cancelOnError];
        return Stream<List<int>>.fromIterable(<List<int>>[kTransparentImage])
            .listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
      });
      return client;
    });
  });
}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}
