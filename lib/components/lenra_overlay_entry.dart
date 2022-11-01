import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_overlay_entry.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';

// TODO : generate this from annotation on LenraOverlayEntry
class LenraOverlayEntryBuilder extends LenraComponentBuilder<LenraApplicationOverlayEntry> {
  @override
  LenraApplicationOverlayEntry map({child, maintainState, opaque, showOverlay}) {
    return LenraApplicationOverlayEntry(
      child: child,
      maintainState: maintainState,
      opaque: opaque,
      showOverlay: showOverlay,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "child": Widget,
      "maintainState": bool,
      "opaque": bool,
      "showOverlay": bool,
    };
  }
}

// ignore: must_be_immutable
class LenraApplicationOverlayEntry extends StatefulWidget {
  Widget? child;
  bool? maintainState;
  bool? opaque;
  bool? showOverlay;

  LenraApplicationOverlayEntry({
    required this.child,
    required this.maintainState,
    required this.opaque,
    required this.showOverlay,
  }) : super();

  @override
  State<LenraApplicationOverlayEntry> createState() {
    return _LenraApplicationOverlayEntryState();
  }
}

class _LenraApplicationOverlayEntryState extends State<LenraApplicationOverlayEntry> {
  @override
  Widget build(BuildContext context) {
    return LenraOverlayEntry(
      child: widget.child,
      maintainState: widget.maintainState ?? false,
      opaque: widget.opaque ?? false,
      showOverlay: widget.showOverlay ?? false,
    );
  }
}
