import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import 'lenra_component_builder.dart';

// TODO : generate this from annotation on LenraApplicationContainer
class LenraContainerBuilder extends LenraComponentBuilder<LenraApplicationContainer> {
  @override
  LenraApplicationContainer map({
    child,
    padding,
    border,
    constraints,
    decoration,
  }) {
    return LenraApplicationContainer(
      child: child,
      padding: padding,
      border: border,
      constraints: constraints,
      decoration: decoration,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "padding": EdgeInsets,
      "border": Border,
      "constraints": BoxConstraints,
      "decoration": BoxDecoration,
      "child": Widget,
    };
  }
}

class LenraApplicationContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Border? border;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;

  LenraApplicationContainer({
    required this.child,
    required this.padding,
    required this.border,
    required this.constraints,
    required this.decoration,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraContainer(
      child: child,
      padding: padding,
      border: border,
      constraints: constraints,
      decoration: decoration,
    );
  }
}
