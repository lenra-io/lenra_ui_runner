import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_component.dart';

// TODO generate this from annotation on LenraMenu
class LenraMenuItemBuilder extends LenraComponentBuilder<LenraApplicationMenuItem> {
  LenraApplicationMenuItem map({text, isSelected, disabled, icon, listeners}) {
    return LenraApplicationMenuItem(
      text: text,
      isSelected: isSelected,
      disabled: disabled,
      icon: icon,
      listeners: listeners,
    );
  }

  Map<String, String> get propsTypes {
    return {
      "text": "String",
      "isSelected": "bool",
      "disabled": "bool",
      "icon": "String",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationMenuItem extends StatelessLenraComponent {
  final String text;
  final bool isSelected;
  final bool disabled;
  final String icon;
  final Map<String, dynamic> listeners;

  LenraApplicationMenuItem({
    required this.text,
    required this.isSelected,
    required this.disabled,
    required this.icon,
    required this.listeners,
  }) : super();

  void onPressed(BuildContext context) {
    final Map<String, String>? listener = this.listeners?['onPressed'];
    if (listener != null && listener.containsKey("code")) {
      LenraOnPressEvent(code: listener['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraMenuItem(
      text: text,
      isSelected: isSelected,
      disabled: disabled,
      icon: ,
      onPressed: () => this.onPressed(context),
    );
  }
}
