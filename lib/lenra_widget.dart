import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';
import 'package:lenra_ui_runner/props_parser.dart';

class LenraWidget<E> extends StatelessWidget {
  final Widget Function(BuildContext, E) buildErrorPage;
  final Function(BuildContext, E) showSnackBar;

  LenraWidget({required this.buildErrorPage, required this.showSnackBar});

  @override
  Widget build(BuildContext context) {
    WidgetModel<E> widgetModel = context.watch<WidgetModel>() as WidgetModel<E>;
    if (widgetModel.hasError() && !widgetModel.hasUi()) return buildErrorPage(context, widgetModel.errors!);
    if (widgetModel.hasError()) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showSnackBar(context, widgetModel.errors!);
      });
    }

    if (!widgetModel.hasUi()) {
      return CircularProgressIndicator();
    }

    Map<String, dynamic> ui = widgetModel.ui;
    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return LenraWidget.parseJson(ui["root"]);
    }

    return LenraWidget.parseJson(ui);
  }

  static Widget parseJson(Map<String, dynamic> json) {
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
