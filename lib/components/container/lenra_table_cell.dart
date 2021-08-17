// import 'package:flutter/material.dart';
// import 'components/lenra_component.dart';
// import 'lenra_component_builder.dart';
// import 'package:lenra_components/lenra_table_cell.dart';

// // TODO : generate this from annotation on LenraTableCell
// class LenraTableCellBuilder extends LenraComponentBuilder<LenraApplicationTableCell> {
//   @override
//   LenraApplicationTableCell map({child, verticalCenter}) {
//     return LenraApplicationTableCell(child: child, verticalCenter: verticalCenter);
//   }

//   Map<String, String> get propsTypes {
//     return {
//       "child": "Widget",
//       "verticalCenter": "bool",
//     };
//   }
// }

// class LenraApplicationTableCell extends StatelessLenraComponent {
//   final Widget child;
//   final bool verticalCenter;

//   LenraApplicationTableCell({
//     this.child,
//     this.verticalCenter,
//   }) : super();

//   @override
//   Widget build(BuildContext context) {
//     return LenraTableCell(
//       child: this.child,
//       verticalCenter: this.verticalCenter,
//     );
//   }
// }
