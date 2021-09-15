import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_component.dart';
import 'package:lenra_ui_runner/helpers/size_helper.dart';
import 'package:lenra_ui_runner/helpers/style_helper.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'events/lenra_on_press_event.dart';
import 'lenra_actionable.dart';

import 'package:lenra_components/component/lenra_button.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraApplicationButton> {
  LenraApplicationButton map({text, disabled, size, mainStyle, listeners}) {
    return LenraApplicationButton(
      text: text,
      disabled: disabled,
      size: size,
      mainStyle: mainStyle,
      listeners: listeners,
    );
  }

  Map<String, String> get propsTypes {
    return {
      "text": "String",
      "disabled": "bool",
      "size": "String",
      "mainStyle": "String",
      "listeners": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationButton extends StatelessLenraComponent implements LenraActionable {
  final String text;
  final bool? disabled;
  final String? size;
  final String? mainStyle;
  final Map<String, dynamic>? listeners;

  LenraApplicationButton({
    required this.text,
    required this.disabled,
    required this.size,
    required this.mainStyle,
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
    return LenraButton(
      text: this.text,
      disabled: this.disabled ?? false,
      size: SizeHelper.fromString(size),
      type: TypeHelper.fromString(mainStyle),
      onPressed: () => this.onPressed(context),
    );
  }
}
