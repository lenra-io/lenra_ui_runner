import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

const List<int> kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
];

void main() {

  late _FakeHttpClient httpClient;

  setUp(() {
    httpClient = _FakeHttpClient();
    debugNetworkImageHttpClientProvider = () => httpClient;
  });

  tearDown(() {
    debugNetworkImageHttpClientProvider = null;
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
  });

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
        "path": "not-existing-path",
        "errorBuilder": {
          "type": "text",
          "value": "Error",
        }
      }
    };

    uiStream.add(ui);

    await tester.pumpAndSettle();
    expect(find.text("Error"), findsOneWidget);
  });

  testWidgets('LenraImage loadingBuilder should build loader widget when the image is loading.', (WidgetTester tester) async {
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
        "path": "long-to-load-image",
        "loadingBuilder": {
          "type": "text",
          "value": "Loading",
        }
      }
    };

    httpClient.request.response
    ..statusCode = HttpStatus.ok
    ..contentLength = kTransparentImage.length
    ..content = chunks;
    
    uiStream.add(ui);

    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Loading"), findsOneWidget);
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

class _FakeHttpClient extends Fake implements HttpClient {
  final _FakeHttpClientRequest request = _FakeHttpClientRequest();
  Object? thrownError;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    if (thrownError != null) {
      throw thrownError!;
    }
    return request;
  }
}
class _FakeHttpClientRequest extends Fake implements HttpClientRequest {
  final _FakeHttpClientResponse response = _FakeHttpClientResponse();

  @override
  Future<HttpClientResponse> close() async {
    return response;
  }
}

class _FakeHttpClientResponse extends Fake implements HttpClientResponse {
  bool drained = false;

  @override
  int statusCode = HttpStatus.ok;

  @override
  int contentLength = 0;

  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  late List<List<int>> content;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable(content).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<E> drain<E>([E? futureValue]) async {
    drained = true;
    return futureValue ?? <int>[] as E;
  }
}

class FakeCodec implements Codec {
  @override
  void dispose() {}

  @override
  int get frameCount => throw UnimplementedError();

  @override
  Future<FrameInfo> getNextFrame() {
    throw UnimplementedError();
  }

  @override
  int get repetitionCount => throw UnimplementedError();
}