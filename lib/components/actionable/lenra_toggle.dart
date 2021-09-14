import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/components/actionable/lenra_actionable.dart';
import 'package:lenra_ui_runner/components/lenra_component.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraCheckbox
class LenraToggleBuilder extends LenraComponentBuilder<LenraApplicationToggle> {
  LenraApplicationToggle map({value, label, disabled, listeners}) {
    return LenraApplicationToggle(value: value, label: label, disabled: disabled, listeners: listeners);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "bool",
      "label": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationToggle extends StatelessLenraComponent implements LenraActionable {
  final bool value;
  final String? label;
  final bool? disabled;
  final Map<String, dynamic>? listeners;

  LenraApplicationToggle({
    required this.value,
    required this.label,
    required this.disabled,
    required this.listeners,
  }) : super();

  void onPressed(bool? newValue, BuildContext context) {
    final Map<String, String>? listener = this.listeners?['onPressed'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnPressEvent(code: listener['code']!, event: {
        "value": newValue,
      }).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraToggle(
      value: this.value,
      label: this.label,
      disabled: this.disabled ?? false,
      onPressed: () => this.onPressed(value, context),
    );
  }
}
