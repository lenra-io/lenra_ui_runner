import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/io_components/lenra_widget.dart';

import 'package:provider/provider.dart';

import 'ui_builder_model.dart';

abstract class UiBuilderState<T extends StatefulWidget, D> extends State<T> {
  Map<String, dynamic> getUi(dynamic data);

  D get data {
    return context.read<UiBuilderModel>().data;
  }

  D getData(Event event);

  @override
  Widget build(BuildContext context) {
    context.read<UiBuilderModel>().initData(getData);
    context.read<UiBuilderModel>().initUi(getUi);
    return LenraWidget(
      buildErrorPage: (_ctx, _e) => Text("error"),
      showSnackBar: (_ctx, _e) => {},
      error: null,
      ui: getUi(data),
    );
  }
}
