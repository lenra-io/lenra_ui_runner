import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_button.dart';
import 'package:lenra_ui_runner/components/lenra_checkbox.dart';
import 'package:lenra_ui_runner/components/lenra_image.dart';
import 'package:lenra_ui_runner/components/lenra_radio.dart';
import 'package:lenra_ui_runner/components/lenra_text.dart';
import 'package:lenra_ui_runner/components/lenra_textfield.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/props_parser.dart';
import 'package:lenra_ui_runner/components/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/components/lenra_flexible.dart';
import 'package:lenra_ui_runner/components/lenra_container.dart';
import 'package:lenra_ui_runner/components/lenra_stack.dart';
import 'package:lenra_ui_runner/components/lenra_slider.dart';
import 'package:lenra_ui_runner/components/lenra_actionable.dart';
import 'package:lenra_ui_runner/components/lenra_menu.dart';
import 'package:lenra_ui_runner/components/lenra_menu_item.dart';
import 'package:lenra_ui_runner/components/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/lenra_status_sticker.dart';
import 'package:lenra_ui_runner/components/lenra_flex.dart';
import 'package:lenra_ui_runner/components/lenra_wrap.dart';

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
  Map<String, dynamic> ui = {};

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

  static final Map<String, LenraComponentBuilder> componentsMapping = {
    'text': LenraTextBuilder(),
    'textfield': LenraTextfieldBuilder(),
    'button': LenraButtonBuilder(),
    'checkbox': LenraCheckboxBuilder(),
    'image': LenraImageBuilder(),
    'radio': LenraRadioBuilder(),
    'menu': LenraMenuBuilder(),
    'menuItem': LenraMenuItemBuilder(),
    'toggle': LenraToggleBuilder(),
    'statusSticker': LenraStatusStickerBuilder(),
    'flex': LenraFlexBuilder(),
    'container': LenraContainerBuilder(),
    'actionable': LenraActionableBuilder(),
    'dropdownButton': LenraDropdownButtonBuilder(),
    'flexible': LenraFlexibleBuilder(),
    'wrap': LenraWrapBuilder(),
    'stack': LenraStackBuilder(),
    'slider': LenraSliderBuilder(),
  };

  static Widget parseJson(Map<String, dynamic> json) {
    String? type = getType(json);
    if (type == null) throw "No type in component. It should never happen";
    LenraComponentBuilder? builder = getComponentBuilder(type);
    if (builder == null) throw "Componnent mapping does not handle type $type";
    Map<Symbol, dynamic> parsedProps = parseProps(json, builder.propsTypes);
    return builder.build(parsedProps);
  }

  static String? getType(Map<String, dynamic> json) {
    return json['type'] as String?;
  }

  static LenraComponentBuilder? getComponentBuilder(String type) {
    if (componentsMapping.containsKey(type)) {
      return componentsMapping[type];
    }

    return null;
  }

  static Map<Symbol, dynamic> parseProps(Map<String, dynamic> json, Map<String, Type> propsTypes) {
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

  static Function? getParser(Type t) {
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
    return parseJson(ui);
  }
}
