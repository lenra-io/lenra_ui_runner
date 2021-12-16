import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

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

    _context!.read<WidgetModel>().replaceUi(ui);

    await tester.pumpAndSettle();
    expect(find.text("Error"), findsOneWidget);
  });

  testWidgets('LenraImage loadingBuilder should build loader widget when the image is loading.',
      (WidgetTester tester) async {
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

    // httpClient.request.response
    //   ..statusCode = HttpStatus.ok
    //   ..contentLength = kTransparentImage.length
    //   ..content = chunks;

    _context!.read<WidgetModel>().replaceUi(ui);

    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Loading"), findsOneWidget);
  });
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
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
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
