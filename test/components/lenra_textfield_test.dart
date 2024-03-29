import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check textfield properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "textfield",
            "value": "",
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var textfieldFinder = find.byType(TextField);
    TextField textfield = tester.widget(textfieldFinder);
    expect(textfieldFinder, findsOneWidget);
    expect(textfield.autocorrect, true);
    expect(textfield.autofillHints, []);
    expect(textfield.autofocus, false);
    expect(textfield.buildCounter, null);
    expect(textfield.style, null);
    expect(textfield.dragStartBehavior, DragStartBehavior.start);
    expect(textfield.enabled, null);
    expect(textfield.enableInteractiveSelection, true);
    expect(textfield.expands, false);
    expect(textfield.keyboardType, TextInputType.text);
    expect(textfield.maxLength, null);
    expect(textfield.maxLengthEnforcement, null);
    expect(textfield.maxLines, 1);
    expect(textfield.minLines, 1);
    expect(textfield.obscureText, false);
    expect(textfield.onAppPrivateCommand, null);
    expect(textfield.onChanged != null, true);
    expect(textfield.onEditingComplete, null);
    expect(textfield.onTap, null);
    expect(textfield.readOnly, false);
    expect(textfield.scrollPhysics, null);
    expect(textfield.showCursor, null);
    expect(textfield.textCapitalization, TextCapitalization.none);
    expect(textfield.textDirection, null);
    expect(textfield.textInputAction, null);
  });

  testWidgets('test onChanged', (WidgetTester tester) async {
    bool hasBeenNotified = false;

    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "textfield",
            "value": "",
            "onChanged": {"code": "yourCode"},
          }
        },
        sendEventFn: (_) {
          hasBeenNotified = true;
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var textfield = find.byType(TextField);
    expect(find.text("foo"), findsNothing);
    await tester.enterText(textfield, "foo");
    await tester.pump();
    expect(find.text("foo"), findsOneWidget);
    await tester.pump(Duration(milliseconds: 500));
    expect(hasBeenNotified, true);
  });

  testWidgets('check textfield style properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "textfield",
            "value": "",
            "style": {
              "cursorColor": 0xFFFFFFFF,
              "cursorHeight": 1,
              "cursorRadius": {"x": 0, "y": 0},
              "keyboardAppearance": "light",
              "obscuringCharacter": "*",
              "scrollPadding": {"top": 2.0, "bottom": 2.0, "right": 2.0, "left": 2.0},
              "selectionHeightStyle": "max",
              "selectionWidthStyle": "max",
              "strutStyle": {"fontSize": 12},
              "textAlignVertical": "bottom"
            }
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var textfieldFinder = find.byType(TextField);
    TextField textfield = tester.widget(textfieldFinder);
    expect(textfieldFinder, findsOneWidget);
    expect(textfield.cursorColor, Colors.white);
    expect(textfield.cursorHeight, 1);
    expect(textfield.cursorRadius, Radius.zero);
    expect(textfield.keyboardAppearance, Brightness.light);
    expect(textfield.obscuringCharacter, "*");
    expect(textfield.scrollPadding, EdgeInsets.all(2));
    expect(textfield.selectionHeightStyle, BoxHeightStyle.max);
    expect(textfield.selectionWidthStyle, BoxWidthStyle.max);
    expect(textfield.strutStyle, StrutStyle(fontSize: 12));
    expect(textfield.textAlignVertical, TextAlignVertical.bottom);
  });

  testWidgets('check textfield style default properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      createBaseTestWidgets(
        ui: {
          "root": {
            "_type": "textfield",
            "value": "",
            "style": {"cursorColor": 0xFF000000},
          }
        },
        sendEventFn: (_) {
          return Future.value(true);
        },
      ),
    );

    await tester.pump();
    var textfieldFinder = find.byType(TextField);
    TextField textfield = tester.widget(textfieldFinder);
    expect(textfieldFinder, findsOneWidget);
    expect(textfield.cursorColor, Colors.black);
    expect(textfield.cursorHeight, null);
    expect(textfield.cursorRadius, null);
    expect(textfield.keyboardAppearance, null);
    expect(textfield.obscuringCharacter, "•");
    expect(textfield.scrollPadding, EdgeInsets.all(20));
    expect(textfield.selectionHeightStyle, BoxHeightStyle.tight);
    expect(textfield.selectionWidthStyle, BoxWidthStyle.tight);
    expect(textfield.strutStyle, null);
    expect(textfield.textAlignVertical, null);
  });
}
