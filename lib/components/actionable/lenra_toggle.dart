import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/components/actionable/lenra_actionable.dart';
import 'package:lenra_ui_runner/components/lenra_component.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraToggle
class LenraToggleBuilder extends LenraComponentBuilder<LenraApplicationToggle> {
  @override
  LenraApplicationToggle map({value, label, disabled, onPressed}) {
    return LenraApplicationToggle(
        value: value, label: label, disabled: disabled, onPressed: onPressed);
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "value": "bool",
      "label": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationToggle extends StatelessLenraComponent
    implements LenraActionable {
  final bool value;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? onPressed;

  LenraApplicationToggle({
    required this.value,
    required this.label,
    required this.disabled,
    required this.onPressed,
  }) : super();

  void onTogglePressed(bool? newValue, BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      LenraOnPressEvent(code: onPressed!['code']!, event: {
        "value": newValue,
      }).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraToggle(
      value: value,
      label: label,
      disabled: disabled ?? false,
      onPressed: () => onTogglePressed(value, context),
    );
  }
}
