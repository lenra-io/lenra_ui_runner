import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/components/lenra_component.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_actionable.dart';
import 'package:lenra_components/component/lenra_checkbox.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraCheckboxBuilder
    extends LenraComponentBuilder<LenraApplicationCheckbox> {
  @override
  LenraApplicationCheckbox map({value, label, disabled, onPressed}) {
    return LenraApplicationCheckbox(
        value: value, label: label, disabled: disabled, onPressed: onPressed);
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "value": "bool",
      "label": "String",
      "disabled": "bool",
      "onPressed": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationCheckbox extends StatelessLenraComponent
    implements LenraActionable {
  final bool value;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? onPressed;

  LenraApplicationCheckbox({
    required this.value,
    required this.label,
    required this.disabled,
    required this.onPressed,
  }) : super();

  void onCheckboxPressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      LenraOnPressEvent(code: onPressed!['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraCheckbox(
      value: value,
      label: label,
      disabled: disabled ?? false,
      onPressed: () => onCheckboxPressed(context),
    );
  }
}
