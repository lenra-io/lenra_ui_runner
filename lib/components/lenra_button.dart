import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/helpers/size_helper.dart';
import 'package:lenra_ui_runner/helpers/style_helper.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'events/on_pressed_event.dart';

import 'package:lenra_components/component/lenra_button.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraApplicationButton> {
  @override
  LenraApplicationButton map({text, disabled, size, mainStyle, onPressed, leftIcon, rightIcon}) {
    return LenraApplicationButton(
      text: text,
      disabled: disabled,
      size: size,
      mainStyle: mainStyle,
      onPressed: onPressed,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "text": "String",
      "disabled": "bool",
      "size": "String",
      "mainStyle": "String",
      "onPressed": "Map<String, dynamic>",
      "leftIcon": "Icon",
      "rightIcon": "Icon",
    };
  }
}

class LenraApplicationButton extends StatelessWidget {
  final String text;
  final bool? disabled;
  final String? size;
  final String? mainStyle;
  final Map<String, dynamic>? onPressed;
  final Icon? leftIcon;
  final Icon? rightIcon;

  LenraApplicationButton({
    required this.text,
    required this.disabled,
    required this.size,
    required this.mainStyle,
    required this.onPressed,
    required this.leftIcon,
    required this.rightIcon,
  }) : super();

  void onButtonPressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      OnPressedEvent(code: onPressed!['code']!).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraButton(
      text: text,
      disabled: disabled ?? false,
      size: SizeHelper.fromString(size),
      type: TypeHelper.fromString(mainStyle),
      onPressed: () => onButtonPressed(context),
      leftIcon: leftIcon,
      rightIcon: rightIcon,
    );
  }
}
