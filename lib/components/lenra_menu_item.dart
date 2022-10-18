import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:provider/provider.dart';

// TODO generate this from annotation on LenraMenuItem
class LenraMenuItemBuilder extends LenraComponentBuilder<LenraApplicationMenuItem> {
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
  Map<String, Type> get propsTypes {
    return {
      "text": String,
      "isSelected": bool,
      "disabled": bool,
      "icon": Widget,
      "onPressed": lenra.Listener,
    };
  }
}

class LenraApplicationMenuItem extends StatelessWidget {
  final String text;
  final bool? isSelected;
  final bool? disabled;
  final Widget? icon;
  final lenra.Listener? onPressed;

  LenraApplicationMenuItem({
    required this.text,
    required this.isSelected,
    required this.disabled,
    required this.icon,
    required this.onPressed,
  }) : super();

  void onMenuItemPressed(BuildContext context) {
    if (onPressed != null) {
      context.read<ChannelModel>().sendEvent(OnPressedEvent(code: onPressed!.code)).then(
            //implement loading
            (value) => null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LenraMenuItem(
      text: text,
      isSelected: isSelected ?? false,
      disabled: disabled ?? false,
      icon: icon,
      onPressed: () => onMenuItemPressed(context),
    );
  }
}
