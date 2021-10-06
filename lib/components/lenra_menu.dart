import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_component.dart';

// TODO generate this from annotation on LenraMenu
class LenraMenuBuilder extends LenraComponentBuilder<LenraApplicationMenu> {
  @override
  LenraApplicationMenu map({children}) {
    return LenraApplicationMenu(children: children);
  }

  @override
  Map<String, String> get propsTypes {
    return {};
  }

  @override
  List<String> get childrenKeys => ["children"];
}

class LenraApplicationMenu extends StatelessLenraComponent {
  final List<Widget> children;

  LenraApplicationMenu({
    required this.children,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraMenu(
      items: children,
    );
  }
}
