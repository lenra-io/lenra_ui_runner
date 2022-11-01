import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_menu.dart';
import 'package:lenra_ui_runner/components/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';

// TODO generate this from annotation on LenraMenu
class LenraMenuBuilder extends LenraComponentBuilder<LenraApplicationMenu> {
  @override
  LenraApplicationMenu map({children}) {
    return LenraApplicationMenu(children: children);
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationMenu extends StatelessWidget {
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
