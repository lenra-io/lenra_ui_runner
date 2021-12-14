import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class LenraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetModel widgetModel = context.watch<WidgetModel>();
    Map<String, dynamic> ui = widgetModel.ui;

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return WidgetModel.parseJson(ui["root"]);
    }

    return WidgetModel.parseJson(ui);
  }
}
