import 'package:flutter/material.dart';
import 'events/lenra_on_press_event.dart';
import 'lenra_actionable.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';
import 'package:lenra_components/lenra_button.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraApplicationButton> {
  LenraApplicationButton map({value, disabled, listeners}) {
    return LenraApplicationButton(value: value, disabled: disabled, listeners: listeners);
  }

  Map<String, String> get propsTypes {
    return {
      "value": "String",
      "disabled": "bool",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationButton extends StatelessLenraComponent implements LenraActionable {
  final String value;
  final bool? disabled;
  final Map<String, dynamic>? listeners;

  LenraApplicationButton({required this.value, required this.disabled, required this.listeners}) : super();

  void onPressed(BuildContext context) {
    final Map<String, String>? listener = this.listeners?['onClick'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnPressEvent(code: listener['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraButton(
      text: this.value,
      disabled: this.disabled ?? false,
      onPressed: () => this.onPressed(context),
    );
  }
}
