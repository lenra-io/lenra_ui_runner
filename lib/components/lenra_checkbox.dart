import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form_checkbox.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder extends LenraComponentBuilder<Widget> {
  @override
  Widget map({
    value,
    tristate,
    onPressed,
    style,
    materialTapTargetSize,
    autofocus,
    name,
  }) {
    if (name != null) {
      return LenraApplicationFormCheckbox(
        value: value,
        tristate: tristate,
        onPressed: onPressed,
        style: style,
        materialTapTargetSize: materialTapTargetSize,
        autofocus: autofocus,
        name: name,
      );
    }
    return LenraApplicationCheckbox(
      value: value,
      tristate: tristate,
      onPressed: onPressed,
      style: style,
      materialTapTargetSize: materialTapTargetSize,
      autofocus: autofocus,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": bool,
      "tristate": bool,
      "onPressed": lenra.Listener,
      "style": LenraCheckboxStyle,
      "materialTapTargetSize": MaterialTapTargetSize,
      "autofocus": bool,
      "name": String,
    };
  }
}

class LenraApplicationCheckbox extends StatelessWidget {
  final bool? value;
  final bool? tristate;
  final lenra.Listener? onPressed;
  final LenraCheckboxStyle? style;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? autofocus;

  LenraApplicationCheckbox({
    required this.value,
    required this.tristate,
    required this.onPressed,
    required this.style,
    required this.materialTapTargetSize,
    required this.autofocus,
  }) : super();

  void onCheck(BuildContext context, bool? value) {
    if (onPressed != null) {
      onPressed!.run(context, (code) => OnChangedEvent(code: code, data: ValueData(value)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraCheckbox(
      value: value,
      tristate: tristate ?? false,
      onPressed: onPressed == null ? null : (v) => onCheck(context, v),
      style: style,
      materialTapTargetSize: materialTapTargetSize,
      autofocus: autofocus ?? false,
    );
  }
}
