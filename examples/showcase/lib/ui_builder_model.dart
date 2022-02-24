import 'package:flutter/widgets.dart';
import 'package:json_patch/json_patch.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/widget_model.dart';

class UiBuilderModel extends ChangeNotifier {
  late WidgetModel widgetModel;
  late Map<String, dynamic> lastUi;
  late Map<String, dynamic> ui;
  late dynamic data;
  late dynamic Function(Event) getData;

  UiBuilderModel({required this.widgetModel});

  void initData(dynamic Function(Event) getData) {
    this.getData = getData;
    data = getData(OnPressedEvent(code: "InitData"));
  }

  void initUi(Map<String, dynamic> ui) {
    this.ui = ui;
    lastUi = ui;
  }

  bool handleNotifications(Event event) {
    data = getData(event);
    var diff = JsonPatch.diff(lastUi, ui);
    lastUi = ui;
    widgetModel.patchUi(diff);

    return true;
  }
}
