import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraToggle
class LenraToggleBuilder extends LenraComponentBuilder<LenraApplicationToggle> {
  @override
  LenraApplicationToggle map({value, label, disabled, onPressed}) {
    return LenraApplicationToggle(value: value, label: label, disabled: disabled, onPressed: onPressed);
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

class LenraApplicationToggle extends StatelessWidget {
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

  void onTogglePressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      OnPressedEvent(code: onPressed!['code']!).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraToggle(
      value: value,
      label: label,
      disabled: disabled ?? false,
      onPressed: () => onTogglePressed(context),
    );
  }
}
