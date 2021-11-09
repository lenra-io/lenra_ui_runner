import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_container.dart';
import '../../lenra_component_builder.dart';

// TODO : generate this from annotation on LenraApplicationStyledContainer
class LenraContainerBuilder extends LenraComponentBuilder<LenraApplicationContainer> {
  @override
  LenraApplicationContainer map({
    child,
    padding,
    constraints,
    decoration,
  }) {
    return LenraApplicationContainer(
      child: child,
      padding: padding,
      constraints: constraints,
      decoration: decoration,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "padding": EdgeInsets,
      "constraints": BoxConstraints,
      "decoration": BoxDecoration,
    };
  }

  @override
  List<String> get childKeys {
    return ["child"];
  }
}

class LenraApplicationContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;

  LenraApplicationContainer({
    required this.child,
    required this.padding,
    required this.constraints,
    required this.decoration,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraContainer(
      child: child,
      padding: padding,
      constraints: constraints,
      decoration: decoration,
    );
  }
}
