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
    onPressedDown,
    onPressedCancel,
    onHovered,
    onFocusChange,
    onHighlightChanged,
  }) {
    return LenraApplicationActionable(
      child: child,
      onPressed: onPressed,
      onDoublePressed: onDoublePressed,
      onLongPressed: onLongPressed,
      onPressedDown: onPressedDown,
      onPressedCancel: onPressedCancel,
      onHovered: onHovered,
      onFocusChange: onFocusChange,
      onHighlightChanged: onHighlightChanged,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "onPressed": "Map<String, dynamic>",
      "onDoublePressed": "Map<String, dynamic>",
      "onLongPressed": "Map<String, dynamic>",
      "onPressedDown": "Map<String, dynamic>",
      "onPressedCancel": "Map<String, dynamic>",
      "onHovered": "Map<String, dynamic>",
      "onFocusChange": "Map<String, dynamic>",
      "onHighlightChange": "Map<String, dynamic>",
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
  final Map<String, dynamic>? onPressedDown;
  final Map<String, dynamic>? onPressedCancel;
  final Map<String, dynamic>? onHovered;
  final Map<String, dynamic>? onFocusChange;
  final Map<String, dynamic>? onHighlightChanged;

  LenraApplicationActionable({
    required this.child,
    required this.onPressed,
    required this.onDoublePressed,
    required this.onLongPressed,
    required this.onPressedDown,
    required this.onPressedCancel,
    required this.onHovered,
    required this.onFocusChange,
    required this.onHighlightChanged,
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
        onTapDown: (e) => onAction(onPressedDown, context),
        onTapCancel: () => onAction(onPressedCancel, context),
        onHover: (e) => onAction(onHovered, context),
        onFocusChange: (e) => onAction(onFocusChange, context),
        onHighlightChanged: (e) => onAction(onHighlightChanged, context),
      ),
    );
  }
}
