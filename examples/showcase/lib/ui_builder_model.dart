import 'package:flutter/widgets.dart';
import 'package:json_patch/json_patch.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';


class UiBuilderModel extends ChangeNotifier {
  late Map<String, dynamic> lastUi;
  late Map<String, dynamic> ui;
  late dynamic data;
  late dynamic Function(Event) getData;
  late Map<String, dynamic> Function(dynamic) getUi;

  UiBuilderModel();

  void initData(dynamic Function(Event) getData) {
    this.getData = getData;
    data = getData(OnPressedEvent(code: "InitData"));
  }

  void initUi(Map<String, dynamic> Function(dynamic) getUi) {
    this.getUi = getUi;
    ui = getUi(data);
    lastUi = ui;
  }

  void handleNotifications(Event event, Function callback) {
    data = getData(event);
    ui = getUi(data);
    var diff = JsonPatch.diff(lastUi, ui);
    lastUi = ui;

    print("HANDLE NOTIFICATION");

    notifyListeners();
    
    // viewModel.patchUi(diff);

    callback("terminated");
  }
}
