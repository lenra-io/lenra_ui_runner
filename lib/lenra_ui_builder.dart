import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_wrapper.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/props_parser.dart';

// Parser le JSON et renvoyer un widget
// Le parser du json prend un composant JSON en entrée, récupérer le type et grâce à ça le builder dans le components mapping
// Exemple avec Flex,

class LenraUiBuilder extends StatefulWidget {
  final StreamController<Map<String, dynamic>> uiStream;
  final StreamController<Iterable<dynamic>> patchUiStream;

  LenraUiBuilder({required this.uiStream, required this.patchUiStream}) : super();

  @override
  State<StatefulWidget> createState() {
    return LenraUiBuilderState();
  }
}

class LenraUiBuilderState extends State<LenraUiBuilder> {
  late Map<String, dynamic> ui;

  @override
  void initState() {
    super.initState();
    widget.uiStream.stream.listen(replaceUi);
    widget.patchUiStream.stream.listen(patchUi);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void parseJson(Map<String, dynamic> json) {
    String? type = getType(json);
    if (type == null) throw "No type in component. It should never happen";
    LenraComponentBuilder? builder = getComponentBuilder(type);
    if (builder == null) throw "Componnent mapping does not handle type $type";
    Map<Symbol, dynamic> parsedProps = parseProps(json, builder.propsTypes);
    builder.build(parsedProps);
  }

  String? getType(Map<String, dynamic> json) {
    return json['type'] as String?;
  }

  LenraComponentBuilder? getComponentBuilder(String type) {
    if (LenraComponentWrapperExt.componentsMapping.containsKey(type)) {
      return LenraComponentWrapperExt.componentsMapping[type];
    }

    return null;
  }

  Map<Symbol, dynamic> parseProps(Map<String, dynamic> json, Map<String, Type> propsTypes) {
    Map<Symbol, dynamic> transformedProps = {};

    json.forEach((key, value) {
      if (propsTypes.containsKey(key)) {
        Function? parser = getParser(propsTypes[value]!);
        if (parser != null) {
          transformedProps[Symbol(key)] = parser(value);
        }
      }
    });

    return transformedProps;
  }

  Function? getParser(Type t) {
    return ParserExt.typeParsers[t];
  }

  void replaceUi(Map<String, dynamic> ui) {
    setState(() {
      // Sauvegarder l'ui qu'on lui passe
      // SetState this.ui = ui;
      this.ui = ui;
    });
  }

  void patchUi(Iterable<dynamic> patches) {
    // Patch (this.ui, patches)
  }

  @override
  Widget build(BuildContext context) {
    // Build this.ui récursivement

    return Container();
  }
}
