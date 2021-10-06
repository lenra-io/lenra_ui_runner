import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_on_press_event.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_component.dart';

// TODO generate this from annotation on LenraClickListener
class LenraClickListenerBuilder extends LenraComponentBuilder<LenraApplicationClickListener> {
  @override
  LenraApplicationClickListener map({child, onPressed}) {
    return LenraApplicationClickListener(child: child, onPressed: onPressed);
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "onPressed": "Map<String, dynamic>",
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationClickListener extends StatelessLenraComponent {
  final Widget child;
  final Map<String, dynamic>? onPressed;

  LenraApplicationClickListener({
    required this.child,
    required this.onPressed,
  }) : super();

  void onWidgetPressed(BuildContext context) {
    if (onPressed != null && onPressed!.containsKey("code")) {
      LenraOnPressEvent(code: onPressed!['code']!, event: {}).dispatch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: child,
        onTap: () => onWidgetPressed(context),
      ),
    );
  }
}
