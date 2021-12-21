import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'lenra_image_test.mocks.dart';

import '../test_helper.dart';

/// One pixel image
Uint8List _opImage =
    base64.decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=');

final MockHttpClient client = MockHttpClient();
final MockHttpClientRequest request = MockHttpClientRequest();
final MockHttpClientResponse response = MockHttpClientResponse();
final MockHttpHeaders headers = MockHttpHeaders();

@GenerateMocks([HttpClient, HttpClientRequest, HttpHeaders], customMocks: [MockSpec<HttpClientResponse>()])
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
      when(client.getUrl(any)).thenAnswer((_) => Future<HttpClientRequest>.value(request));
      when(request.headers).thenReturn(headers);
      when(request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
      when(response.contentLength).thenReturn(_opImage.length);
      when(response.statusCode).thenReturn(HttpStatus.ok);
      when(response.compressionState).thenReturn(HttpClientResponseCompressionState.notCompressed);
      when(response.listen(any)).thenAnswer((Invocation invocation) {
        final void Function(List<int>) onData = invocation.positionalArguments[0];
        final void Function() onDone = invocation.namedArguments[#onDone];
        final void Function(Object, [StackTrace]) onError = invocation.namedArguments[#onError];
        final bool cancelOnError = invocation.namedArguments[#cancelOnError];
        return Stream<List<int>>.fromIterable(<List<int>>[_opImage])
            .listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
      });
      return client;
    });
  });
}
