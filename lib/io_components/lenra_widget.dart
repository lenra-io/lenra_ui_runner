import 'package:client_common/api/response_models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';
import 'package:lenra_ui_runner/props_parser.dart';

class LenraWidget extends StatelessWidget {
  final Widget Function(BuildContext, ApiError) buildErrorPage;
  final Function(BuildContext, ApiError) showSnackBar;
  final ApiError? error;
  final Map<String, dynamic>? ui;

  LenraWidget({
    required this.buildErrorPage,
    required this.showSnackBar,
    required this.error,
    required this.ui,
  });

  @override
  Widget build(BuildContext context) {
    if (hasError() && !hasUi()) return buildErrorPage(context, error!);
    if (hasError()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(context, error!);
      });
    }

    if (!hasUi()) {
      return CircularProgressIndicator();
    }

    if (ui!.keys.contains("root") && ui!.keys.length == 1) {
      return LenraWidget.parseJson(ui!["root"]);
    }

    return LenraWidget.parseJson(ui!);
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

  bool hasError() {
    return error != null;
  }

  bool hasUi() {
    return ui != null;
  }
}
