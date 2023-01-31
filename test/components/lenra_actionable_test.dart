import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_actionable.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

import '../mock_channel_model.dart';
import "../test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  late int eventsNb;

  setUp(() {
    eventsNb = 0;
  });

  testWidgets('Check correctly built and listener working', (WidgetTester tester) async {
    BuildContext? _context;
    eventsNb = 0;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;
            (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
              eventsNb += 1;
            });

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
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

    _context!.read<ViewModel>().replaceUi(ui);

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
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;
            (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
              eventsNb += 1;
            });

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
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

    _context!.read<ViewModel>().replaceUi(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    expect(eventsNb, 1);
  });

  testWidgets('onPressed does not conflict with onDoublePressed', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;
            (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
              eventsNb += 1;
            });

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
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

    _context!.read<ViewModel>().replaceUi(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });

  testWidgets('onDoublePressed does not conflict with onPressed', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;
            (Provider.of<ChannelModel>(context, listen: false) as MockChannelModel).setCallBack((value) {
              eventsNb += 1;
            });

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
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

    _context!.read<ViewModel>().replaceUi(ui);
    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byType(InkWell));
    await tester.pump(kDoubleTapTimeout);
    expect(eventsNb, 1);
  });
  testWidgets('Test default Color for the actionable', (WidgetTester tester) async {
    BuildContext? _context;

    await tester.pumpWidget(
      createBaseTestWidgets(
        child: Builder(
          builder: (BuildContext context) {
            _context = context;

            return LenraWidget(
              buildErrorPage: (_ctx, _e) => Text("error"),
              showSnackBar: (_ctx, _e) => {},
            );
          },
        ),
      ),
    );

    Map<String, dynamic> ui = {
      "root": {
        "type": "actionable",
        "child": {"type": "text", "value": "Purple"}
      },
    };

    _context!.read<ViewModel>().replaceUi(ui);
    await tester.pump();
    var finder = find.descendant(
      of: find.byType(LenraApplicationActionable),
      matching: find.byType(Material),
    );
    expect((tester.widget(finder) as Material).color, Colors.transparent);
  });
}
