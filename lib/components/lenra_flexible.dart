import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

class LenraFlexibleBuilder extends LenraComponentBuilder<LenraApplicationFlexible> {
  @override
  LenraApplicationFlexible map({child, fit, flex}) {
    return LenraApplicationFlexible(child: child, fit: fit, flex: flex);
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "fit": FlexFit,
      "flex": int,
      "child": Widget,
    };
  }
}

class LenraApplicationFlexible extends StatelessWidget {
  final Widget child;
  final FlexFit? fit;
  final int? flex;

  LenraApplicationFlexible({
    required this.child,
    required this.fit,
    required this.flex,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: child,
      fit: fit ?? FlexFit.tight,
      flex: flex ?? 1,
    );
  }
}
