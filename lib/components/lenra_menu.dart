import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'lenra_component.dart';


// TODO generate this from annotation on LenraMenu
class LenraMenuBuilder extends LenraComponentBuilder<LenraApplicationMenu> {
  LenraApplicationMenu map({children}) {
    return LenraApplicationMenu(children: children);
  }

  Map<String, String> get propsTypes {
    return {
      "children": "List<Widget>",
    };
  }
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
