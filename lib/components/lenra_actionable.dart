import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_component.dart';

// TODO generate this from annotation on LenraActionable
class LenraActionableBuilder extends LenraComponentBuilder<LenraApplicationActionable> {
  @override
  LenraApplicationActionable map({
    child,
    onPressed,
    onDoublePressed,
    onLongPressed,
    onPressedCancel,
    onHovered,
  }) {
    return LenraApplicationActionable(
      child: child,
      onPressed: onPressed,
      onDoublePressed: onDoublePressed,
      onLongPressed: onLongPressed,
      onPressedCancel: onPressedCancel,
      onHovered: onHovered,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "onPressed": "Map<String, dynamic>",
      "onDoublePressed": "Map<String, dynamic>",
      "onLongPressed": "Map<String, dynamic>",
      "onPressedCancel": "Map<String, dynamic>",
      "onHovered": "Map<String, dynamic>",
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationActionable extends StatelessLenraComponent {
  final Widget child;
  final Map<String, dynamic>? onPressed;
  final Map<String, dynamic>? onDoublePressed;
  final Map<String, dynamic>? onLongPressed;
  final Map<String, dynamic>? onPressedCancel;
  final Map<String, dynamic>? onHovered;

  LenraApplicationActionable({
    required this.child,
    required this.onPressed,
    required this.onDoublePressed,
    required this.onLongPressed,
    required this.onPressedCancel,
    required this.onHovered,
  }) : super();

  void onAction(Map<String, dynamic>? action, BuildContext context) {
    if (action != null && action.containsKey("code")) {
      LenraOnPressEvent(code: action['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: child,
        onTap: () => onAction(onPressed, context),
        onDoubleTap: () => onAction(onDoublePressed, context),
        onLongPress: () => onAction(onLongPressed, context),
        onTapCancel: () => onAction(onPressedCancel, context),
        onHover: (e) => onAction(onHovered, context),
      ),
    );
  }
}
