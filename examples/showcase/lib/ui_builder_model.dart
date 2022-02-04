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

  void initUi(Map<String, dynamic> ui, dynamic Function(Event) getData) {
    print("INIT UI");
    this.getData = getData;
    data = getData(OnPressedEvent(code: "InitData"));
    this.ui = ui;

    print(data);
    print(this.ui);
  }

  bool handleNotifications(Event event) {
    print("HANDLING NOTIFICATION");
    data = getData(event);
    var diff = JsonPatch.diff(lastUi, ui);
    widgetModel.patchUi(diff);

    print(data);
    print(ui);

    return true;
  }
}
