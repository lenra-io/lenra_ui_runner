import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_styled_container.dart';
import '../../lenra_component_builder.dart';

// TODO : generate this from annotation on LenraApplicationStyledContainer
class LenraStyledContainerBuilder extends LenraComponentBuilder<LenraApplicationStyledContainer> {
  @override
  LenraApplicationStyledContainer map({
    child,
    color,
    border,
    borderRadius,
    boxShadow,
    padding,
  }) {
    return LenraApplicationStyledContainer(
      child: child,
      color: color,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      padding: padding,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "color": Color,
      "border": Border,
      "borderRadius": BorderRadius,
      "boxShadow": BoxShadow,
      "padding": EdgeInsets,
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationStyledContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final EdgeInsets? padding;

  LenraApplicationStyledContainer({
    required this.child,
    required this.color,
    required this.border,
    required this.borderRadius,
    required this.boxShadow,
    required this.padding,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraStyledContainer(
      child: child,
      color: color,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      padding: padding,
    );
  }
}
