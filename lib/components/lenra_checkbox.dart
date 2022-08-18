import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_checkbox_style.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder extends LenraComponentBuilder<LenraApplicationCheckbox> {
  @override
  LenraApplicationCheckbox map({
    value,
    tristate,
    onPressed,
    style,
    materialTapTargetSize,
    autofocus,
    name,
  }) {
    return LenraApplicationCheckbox(
      value: value,
      tristate: tristate,
      onPressed: onPressed,
      style: style,
      materialTapTargetSize: materialTapTargetSize,
      autofocus: autofocus,
      name: name,
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
  final String? name;

  LenraApplicationCheckbox({
    required this.value,
    required this.tristate,
    required this.onPressed,
    required this.style,
    required this.materialTapTargetSize,
    required this.autofocus,
    required this.name,
  }) : super();

  void onCheck(BuildContext context, bool? value) {
    if (onPressed != null) {
      if (name != null) {
        context.read<FormProvider?>()?.setFormFieldValue(name!, value);
      }
      OnChangedEvent(code: onPressed!.code, data: ValueData(value)).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (name != null) {
      context.read<FormProvider?>()?.setFormFieldValue(name!, value);
    }

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
