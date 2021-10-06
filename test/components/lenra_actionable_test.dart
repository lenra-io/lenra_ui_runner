import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  late StreamController<Map<String, dynamic>> uiStream;
  late StreamController<List<Map<String, dynamic>>> patchUiStream;
  late int eventsNb;

  setUp(() {
    uiStream = StreamController();
    patchUiStream = StreamController();
    eventsNb = 0;
  });

  testWidgets('Check correctly built and listener working', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "doublePressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onDoublePressed": {
          "code": "doublePressed",
        }
      }
    };

    uiStream.add(ui);

    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });

  testWidgets('onPressed working', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "pressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onPressed": {
          "code": "pressed",
        }
      }
    };

    uiStream.add(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    expect(eventsNb, 1);
  });

  testWidgets('onPressed does not conflict with onDoublePressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "pressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onPressed": {
          "code": "pressed",
        },
        "onDoublePressed": {"code": "doublePressed"}
      }
    };

    uiStream.add(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });

  testWidgets('onDoublePressed does not conflict with onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        child: NotificationListener(
          child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
          onNotification: (LenraEvent e) {
            expect(e.code, "doublePressed");
            eventsNb = eventsNb + 1;
            return true;
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {
          "type": "text",
          "value": "foo",
        },
        "onPressed": {
          "code": "pressed",
        },
        "onDoublePressed": {"code": "doublePressed"}
      }
    };

    uiStream.add(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });
}
