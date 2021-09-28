import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';

// TODO : generate this from annotation on LenraApplicationStyledContainer
class LenraStyledContainerBuilder extends LenraComponentBuilder<LenraApplicationStyledContainer> {
  @override
  LenraApplicationStyledContainer map({
    child,
    backgroundColor,
    border,
    borderRadius,
    boxShadow,
  }) {
    return LenraApplicationStyledContainer(
      child: child,
      backgroundColor: backgroundColor,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
    );
  }

  @override
  Map<String, String> get propsTypes {
    return {
      "child": "Widget",
      "backgroundColor": "Color",
      "border": "Border",
      "borderRadius": "BorderRadius",
      "boxShadow": "BoxShadow",
    };
  }
}

class LenraApplicationStyledContainer extends StatelessLenraComponent {
  final Widget child;
  final Color? backgroundColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;

  LenraApplicationStyledContainer({
    required this.child,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.boxShadow,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraStyledContainer(
      child: child,
      color: backgroundColor,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
    );
  }
}
