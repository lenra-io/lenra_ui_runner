import 'package:flutter/material.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/components/lenra_form.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/helpers/style_helper.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:provider/provider.dart';
import 'events/on_pressed_event.dart';

import 'package:lenra_components/component/lenra_button.dart';

// TODO : generate this from annotation on LenraButton
class LenraButtonBuilder extends LenraComponentBuilder<LenraApplicationButton> {
  @override
  LenraApplicationButton map({
    text,
    disabled,
    size,
    mainStyle,
    onPressed,
    leftIcon,
    rightIcon,
    submit = false,
  }) {
    return LenraApplicationButton(
      text: text,
      disabled: disabled,
      size: size,
      mainStyle: mainStyle,
      onPressed: onPressed,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      submit: submit,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "text": String,
      "disabled": bool,
      "size": LenraComponentSize,
      "mainStyle": String,
      "onPressed": lenra.Listener,
      "leftIcon": Widget,
      "rightIcon": Widget,
      "submit": bool,
    };
  }
}

class LenraApplicationButton extends StatelessWidget {
  final String text;
  final bool? disabled;
  final LenraComponentSize? size;
  final String? mainStyle;
  final lenra.Listener? onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool submit;

  LenraApplicationButton({
    required this.text,
    required this.disabled,
    required this.size,
    required this.mainStyle,
    required this.onPressed,
    required this.leftIcon,
    required this.rightIcon,
    required this.submit,
  }) : super();

  void onButtonPressed(BuildContext context) {
    if (submit) {
      context.read<FormProvider?>()?.submitForm();
    }
    if (onPressed != null) {
      onPressed!.run(context, (code) => OnPressedEvent(code: code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraButton(
      text: text,
      disabled: disabled ?? false,
      size: size ?? LenraComponentSize.medium,
      type: TypeHelper.fromString(mainStyle),
      onPressed: () {
        onButtonPressed(context);
      },
      leftIcon: leftIcon,
      rightIcon: rightIcon,
    );
  }
}
