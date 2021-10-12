import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;

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
  Map<String, Type> get propsTypes {
    return {
      "onPressed": Listener,
      "onDoublePressed": Listener,
      "onLongPressed": Listener,
      "onPressedCancel": Listener,
      "onHovered": Listener,
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationActionable extends StatelessWidget {
  final Widget child;
  final lenra.Listener? onPressed;
  final lenra.Listener? onDoublePressed;
  final lenra.Listener? onLongPressed;
  final lenra.Listener? onPressedCancel;
  final lenra.Listener? onHovered;

  LenraApplicationActionable({
    required this.child,
    required this.onPressed,
    required this.onDoublePressed,
    required this.onLongPressed,
    required this.onPressedCancel,
    required this.onHovered,
  }) : super();

  void onAction(lenra.Listener? action, BuildContext context) {
    if (action != null) {
      OnPressedEvent(code: action.code).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: child,
        onTap: () => onAction(onPressed, context),
        onDoubleTap: onDoublePressed != null ? () => onAction(onDoublePressed, context) : null,
        onLongPress: () => onAction(onLongPressed, context),
        onTapCancel: () => onAction(onPressedCancel, context),
        onHover: (e) => onAction(onHovered, context),
      ),
    );
  }
}