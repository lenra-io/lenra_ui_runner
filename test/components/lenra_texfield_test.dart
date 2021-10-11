import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';

import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  testWidgets('check textfield properties', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "textfield",
        "value": "foo",
        "label": "bar",
        "size": "large",
        "minLines": 2,
        "maxLines": 4,
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var textfield = find.byType(LenraTextField);
    expect(tester.widget<LenraTextField>(textfield).maxLines, 4);
    expect(tester.widget<LenraTextField>(textfield).minLines, 2);
    expect(tester.widget<LenraTextField>(textfield).size, LenraComponentSize.large);
    expect(find.byType(LenraTextField), findsOneWidget);
    expect(find.text("foo"), findsOneWidget);
    expect(find.text("bar"), findsOneWidget);
  });

  testWidgets('test onChanged', (WidgetTester tester) async {
    StreamController<Map<String, dynamic>> uiStream = StreamController();
    StreamController<List<Map<String, dynamic>>> patchUiStream = StreamController();

    bool isEnterNotification = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
          child: NotificationListener(
        child: LenraUiBuilder(uiStream: uiStream, patchUiStream: patchUiStream),
        onNotification: (OnChangedEvent e) {
          expect(e.code, "yourCode");
          isEnterNotification = true;
          expect(e.data.value, "foo");
          return false;
        },
      )),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "textfield",
        "value": "",
        "onChanged": {"code": "yourCode"},
      }
    };

    uiStream.add(ui);

    await tester.pump();
    var textfield = find.byType(TextField);
    await tester.enterText(textfield, "foo");
    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    await tester.pump(Duration(milliseconds: 500));
    expect(isEnterNotification, true);
  });
}
