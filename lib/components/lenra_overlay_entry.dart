import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_overlay_entry.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraOverlayEntry
class LenraOverlayEntryBuilder extends LenraComponentBuilder<LenraApplicationOverlayEntry> {
  @override
  LenraApplicationOverlayEntry map({child, maintainState, opaque}) {
    return LenraApplicationOverlayEntry(child: child, maintainState: maintainState, opaque: opaque);
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "child": Widget,
      "maintainState": bool,
      "opaque": bool,
    };
  }
}

class LenraApplicationOverlayEntry extends StatelessWidget {
  final Widget? child;
  final bool? maintainState;
  final bool? opaque;

  LenraApplicationOverlayEntry({
    required this.child,
    required this.maintainState,
    required this.opaque,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraOverlayEntry(
      child: child,
      maintainState: maintainState ?? false,
      opaque: opaque ?? false,
    );
  }
}
