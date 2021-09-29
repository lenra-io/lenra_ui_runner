import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/utils/icon_util.dart';
import 'lenra_component.dart';

// TODO generate this from annotation on LenraMenuItem
class LenraMenuItemBuilder
    extends LenraComponentBuilder<LenraApplicationMenuItem> {
  @override
  LenraApplicationMenuItem map({text, isSelected, disabled, icon, onPressed}) {
    return LenraApplicationMenuItem(
      text: text,
      isSelected: isSelected,
      disabled: disabled,
      icon: icon,
      onPressed: onPressed,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "text": "String",
      "isSelected": "bool",
      "disabled": "bool",
      "icon": "String",
      "onPressed": "Map<String, dynamic>",
    };
  }
}

class LenraApplicationMenuItem extends StatelessLenraComponent {
  final String text;
  final bool? isSelected;
  final bool? disabled;
  final String? icon;
  final Map<String, dynamic>? onPressed;

  LenraApplicationMenuItem({
    required this.text,
    required this.isSelected,
    required this.disabled,
    required this.icon,
    required this.onPressed,
  }) : super();

  void onMenuItemPressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      LenraOnPressEvent(code: onPressed!['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData? iconData = IconUtil.fromString(icon);
    return LenraMenuItem(
      text: text,
      isSelected: isSelected ?? false,
      disabled: disabled ?? false,
      icon: iconData == null ? null : _buildIcon(iconData),
      onPressed: () => onMenuItemPressed(context),
    );
  }

  Widget _buildIcon(IconData iconData) {
    return Icon(
      Icons.airplanemode_active,
      color: Colors.white,
      size: 16,
    );
  }
}