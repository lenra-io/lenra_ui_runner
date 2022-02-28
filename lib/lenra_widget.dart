import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:lenra_ui_runner/props_parser.dart';

class LenraWidget extends StatelessWidget {
  static Function? appErrorUI;
  static Function? appErrorCallback;
  static List<Widget>? _errors;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ui = context.select<WidgetModel, Map<String, dynamic>>((model) => model.ui);

    bool error = context.select<WidgetModel, bool>((model) => model.error);

    if (error) {
      Map<dynamic, dynamic>? errors = context.select<WidgetModel, Map<dynamic, dynamic>?>((model) => model.errors);
      for (var error in errors!["errors"]) {
        LenraWidget._errors = [];
        LenraWidget._errors!.add(Text("Error code: " + error["code"].toString()));
        LenraWidget._errors!.add(Text(
          "Message: " + error["message"],
          textAlign: TextAlign.center,
        ));
      }
      appErrorCallback!(context, error);
    }

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return LenraWidget.parseJson(ui["root"]);
    }

    return LenraWidget.parseJson(ui);
  }

  static Widget parseJson(Map<String, dynamic> json) {
    if (json.isEmpty) return LenraWidget.appErrorUI != null ? appErrorUI!(_errors) : Text("Unknow error");

    String? type = Parser.getType(json);
    if (type == null) {
      throw "No type in component. It should never happen";
    }
    LenraComponentBuilder? builder = Parser.getComponentBuilder(type);
    if (builder == null) throw "Componnent mapping does not handle type $type";
    Map<Symbol, dynamic> parsedProps = Parser.parseProps(json, builder.propsTypes);
    return builder.build(parsedProps);
  }
}
