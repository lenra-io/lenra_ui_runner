import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_dropdown_button.dart';
import 'package:lenra_components/theme/lenra_theme_data.dart';
import 'package:lenra_ui_runner/helpers/style_helper.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraButton
class LenraDropdownButtonBuilder extends LenraComponentBuilder<LenraApplicationDropdownButton> {
  @override
  LenraApplicationDropdownButton map({
    text,
    disabled,
    size,
    mainStyle,
    child,
    icon,
  }) {
    return LenraApplicationDropdownButton(
      text: text,
      disabled: disabled,
      size: size,
      mainStyle: mainStyle,
      child: child,
      icon: icon,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "text": String,
      "disabled": bool,
      "size": LenraComponentSize,
      "mainStyle": String,
      "icon": Icon,
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationDropdownButton extends StatelessWidget {
  final String text;
  final bool? disabled;
  final LenraComponentSize? size;
  final String? mainStyle;
  final Widget child;
  final Icon? icon;

  LenraApplicationDropdownButton({
    required this.text,
    required this.disabled,
    required this.size,
    required this.mainStyle,
    required this.child,
    required this.icon,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraDropdownButton(
      text: text,
      disabled: disabled ?? false,
      size: size ?? LenraComponentSize.medium,
      type: TypeHelper.fromString(mainStyle),
      child: child,
      icon: icon,
    );
  }
}
