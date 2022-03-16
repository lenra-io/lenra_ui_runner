import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

abstract class UiBuilderState<T extends StatefulWidget, D> extends State<T> {
  late Map<String, dynamic> lastUi;
  late D data;

  Map<String, dynamic> get ui;

  D getData(Event event);

  @override
  void initState() {
    super.initState();
    data = getData(OnPressedEvent(code: "InitData"));
    lastUi = ui;

    /// replaceUi is called after the first frame is rendered because the provider is only accessible at that point.
    WidgetsBinding.instance?.addPostFrameCallback((_) => context.read<WidgetModel>().replaceUi(ui));
  }

  bool handleNotifications(Event event) {
    data = getData(event);
    var newUi = ui;
    var diff = JsonPatch.diff(lastUi, newUi);
    lastUi = newUi;
    context.read<WidgetModel>().patchUi(diff);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<Event>(
      onNotification: (Event event) => handleNotifications(event),
      child: LenraWidget(
        buildErrorPage: (_context, _error) {
          return Text("Error");
        },
        showSnackBar: (_context, _errors) {},
      ),
    );
  }
}
