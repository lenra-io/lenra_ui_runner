import 'package:flutter/material.dart';
import 'package:lenra_components/layout/lenra_stack.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';

// TODO : generate this from annotation on LenraStack
class LenraStackBuilder extends LenraComponentBuilder<LenraApplicationStack> {
  @override
  LenraApplicationStack map({
    children,
    alignment,
    fit,
  }) {
    return LenraApplicationStack(
      children: children,
      alignment: alignment,
      fit: fit,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "alignment": Alignment,
      "fit": StackFit,
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationStack extends StatelessWidget {
  final List<Widget> children;
  final Alignment? alignment;
  final StackFit? fit;

  LenraApplicationStack({
    required this.children,
    required this.alignment,
    required this.fit,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraStack(
      children: children,
      alignment: alignment,
      fit: fit,
    );
  }
}
