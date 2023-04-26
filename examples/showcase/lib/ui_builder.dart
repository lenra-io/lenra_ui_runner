import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/lenra_widget.dart';

import 'package:provider/provider.dart';

import 'ui_builder_model.dart';

abstract class UiBuilderState<T extends StatefulWidget, D> extends State<T> {
  Map<String, dynamic> getUi(dynamic data);

  D get data {
    return context.read<UiBuilderModel>().data;
  }

  D getData(Event event);

  @override
  void initState() {
    super.initState();

    /// replaceUi is called after the first frame is rendered because the provider is only accessible at that point.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewModel>().replaceUi(getUi(data));
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<UiBuilderModel>().initData(getData);
    context.read<UiBuilderModel>().initUi(getUi);
    return LenraWidget(
      buildErrorPage: (_context, _error) {
        return Text("Error");
      },
      showSnackBar: (_context, _errors) {},
    );
  }
}
