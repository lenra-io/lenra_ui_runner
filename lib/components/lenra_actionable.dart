import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/on_pressed_event.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:provider/provider.dart';

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
      "onPressed": lenra.Listener,
      "onDoublePressed": lenra.Listener,
      "onLongPressed": lenra.Listener,
      "onPressedCancel": lenra.Listener,
      "onHovered": lenra.Listener,
      "child": Widget,
    };
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
      action.run(context, (code) => OnPressedEvent(code: code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
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
