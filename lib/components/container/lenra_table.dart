import 'package:flutter/material.dart';
import '../lenra_component.dart';
import '../../lenra_component_builder.dart';
import 'package:lenra_components/component/lenra_table.dart';
import 'package:lenra_components/component/lenra_table_row.dart';

// TODO : generate this from annotation on LenraTable
class LenraTableBuilder extends LenraComponentBuilder<LenraApplicationTable> {
  @override
  LenraApplicationTable map({children, centerChildren, border}) {
    return LenraApplicationTable(children: children, border: border);
  }

  Map<String, String> get propsTypes {
    return {
      "children": "List<Widget>",
      "centerChildren": "bool",
      "border": "bool",
    };
  }
}

class LenraApplicationTable extends StatelessLenraComponent {
  final List<LenraTableRow> children;

  final bool? border;

  LenraApplicationTable({
    required this.children,
    required this.border,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraTable(
      children: this.children,
      border: this.border ?? false,
    );
  }
}
