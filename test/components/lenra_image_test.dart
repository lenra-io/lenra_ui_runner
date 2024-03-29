import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_test/flutter_test.dart';
import 'lenra_image_test.mocks.dart';

import '../test_helper.dart';

/// One pixel image
Uint8List _opImage =
    base64.decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=');

final MockHttpClient client = MockHttpClient();
final MockHttpClientRequest request = MockHttpClientRequest();
final MockHttpClientResponse response = MockHttpClientResponse();
final MockHttpHeaders headers = MockHttpHeaders();

HttpClient createClient() {
  var client = MockHttpClient();
  Stream<List<int>> stream = Stream<List<int>>.fromIterable([_opImage]);
  when(client.getUrl(Uri.parse("long-to-load-image"))).thenAnswer((_) {
    print('load');
    return Future<HttpClientRequest>.value(request);
  });
  when(request.headers).thenReturn(headers);
  when(request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(response.contentLength).thenReturn(_opImage.length);
  when(response.statusCode).thenReturn(HttpStatus.ok);
  when(response.compressionState).thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(response.listen(any,
          onDone: anyNamed('onDone'), onError: anyNamed('onError'), cancelOnError: anyNamed('cancelOnError')))
      .thenAnswer((Invocation invocation) {
    print('listen');
    return stream.listen((data) {
      print(data);
      invocation.positionalArguments[0](data);
    });
  });
  return client;
}

@GenerateMocks([HttpClient, HttpClientRequest, HttpHeaders], customMocks: [MockSpec<HttpClientResponse>()])
void main() {
  testWidgets('LenraImage errorPlaceHolder should build error widget when an error occurs.',
      (WidgetTester tester) async {
    await HttpOverrides.runZoned(
      () async {
        await tester.pumpWidget(
          createBaseTestWidgets(
            ui: {
              "root": {
                "_type": "image",
                "src": "not-existing-path",
                "errorPlaceHolder": {
                  "_type": "text",
                  "value": "Error",
                }
              }
            },
            sendEventFn: (_) {
              return Future.value(true);
            },
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text("Error"), findsOneWidget);
      },
      createHttpClient: (_) => createClient(),
    );
  });

  // testWidgets('LenraImage loadingPlaceHolder should build loader widget when the image is loading.',
  //     (WidgetTester tester) async {
  //   LenraWidget widget = LenraWidget(
  //     buildErrorPage: (_ctx, _e) => Text("error"),
  //     showSnackBar: (_ctx, _e) => {},
  //     error: null,
  //     ui: {
  //       "root": {
  //         "_type": "image",
  //         "src": "long-to-load-image",
  //         "loadingPlaceHolder": {
  //           "_type": "text",
  //           "value": "Loading",
  //         },
  //         "errorPlaceHolder": {
  //           "_type": "text",
  //           "value": "Error",
  //         }
  //       }
  //     },
  //   );

  //   await HttpOverrides.runZoned(
  //     () async {
  //       await tester.pumpWidget(
  //         createBaseTestWidgets(
  //           child: widget,
  //           sendEventFn: (_) {
  //             return Future.value(true);
  //           },
  //         ),
  //       );

  //       await tester.pump();

  //       expect(find.byType(LenraImage), findsOneWidget);
  //       expect(find.text("Loading"), findsOneWidget);
  //     },
  //     createHttpClient: (_) => createClient(),
  //   );
  // });

  // testWidgets('LenraImage framePlaceHolder should build placeholder Widget while the image is loading.',
  //     (WidgetTester tester) async {
  //   LenraWidget widget = LenraWidget(
  //     buildErrorPage: (_ctx, _e) => Text("error"),
  //     showSnackBar: (_ctx, _e) => {},
  //     error: null,
  //     ui: {
  //       "root": {
  //         "_type": "image",
  //         "src": "long-to-load-image",
  //         "framePlaceHolder": {
  //           "_type": "text",
  //           "value": "Frame",
  //         },
  //         "errorPlaceHolder": {
  //           "_type": "text",
  //           "value": "Error",
  //         }
  //       }
  //     },
  //   );

  //   await HttpOverrides.runZoned(
  //     () async {
  //       await tester.pumpWidget(
  //         createBaseTestWidgets(
  //           child: widget,
  //           sendEventFn: (_) {
  //             return Future.value(true);
  //           },
  //         ),
  //       );

  //       await tester.pump();

  //       expect(find.byType(LenraImage), findsOneWidget);
  //       expect(find.text("Frame"), findsOneWidget);
  //     },
  //     createHttpClient: (_) => createClient(),
  //   );
  // });

  // testWidgets('LenraImage width and height should be properly applied to the component.', (WidgetTester tester) async {
  //   LenraWidget widget = LenraWidget(
  //     buildErrorPage: (_ctx, _e) => Text("error"),
  //     showSnackBar: (_ctx, _e) => {},
  //     error: null,
  //     ui: {
  //       "root": {
  //         "_type": "image",
  //         "width": 500,
  //         "height": 500,
  //         "src": "long-to-load-image",
  //         "errorPlaceHolder": {
  //           "_type": "text",
  //           "value": "Error",
  //         }
  //       }
  //     },
  //   );

  //   await HttpOverrides.runZoned(
  //     () async {
  //       await tester.pumpWidget(
  //         createBaseTestWidgets(
  //           child: widget,
  //           sendEventFn: (_) {
  //             return Future.value(true);
  //           },
  //         ),
  //       );

  //       await tester.pump();

  //       expect(find.byType(LenraImage), findsOneWidget);
  //       expect(tester.getSize(find.byType(LenraImage)), Size(500, 500));
  //     },
  //     createHttpClient: (_) => createClient(),
  //   );
  // });
}
