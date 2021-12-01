import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_toggle.dart';
import 'package:lenra_components/theme/lenra_toggle_syle.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraToggle
class LenraToggleBuilder extends LenraComponentBuilder<LenraApplicationToggle> {
  @override
  LenraApplicationToggle map({
    value,
    onPressed,
    style,
    splashRadius,
    autofocus,
    dragStartBehavior,
  }) {
    return LenraApplicationToggle(
      value: value,
      onPressed: onPressed,
      style: style,
      splashRadius: splashRadius,
      autofocus: autofocus,
      dragStartBehavior: dragStartBehavior,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "value": bool,
      "onPressed": Listener,
      "style": LenraToggleStyle,
      "splashRadius": double,
      "autofocus": bool,
      "dragStartBehavior": DragStartBehavior,
    };
  }
}

class LenraApplicationToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onPressed;
  final LenraToggleStyle? style;
  final double? splashRadius;
  final bool autofocus;
  final DragStartBehavior dragStartBehavior;

  LenraApplicationToggle({
    required this.value,
    required this.onPressed,
    required this.style,
    required this.splashRadius,
    required this.autofocus,
    required this.dragStartBehavior,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraToggle(
      value: value,
      onPressed: onPressed,
      style: style,
      splashRadius: splashRadius,
      autofocus: autofocus,
      dragStartBehavior: dragStartBehavior,
    );
  }
}
