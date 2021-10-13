import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/lenra_dropdown_button.dart';
import 'package:lenra_ui_runner/components/lenra_flexible.dart';
import 'package:lenra_ui_runner/components/lenra_styled_container.dart';
import 'package:lenra_ui_runner/components/lenra_actionable.dart';
import 'package:lenra_ui_runner/components/lenra_menu.dart';
import 'package:lenra_ui_runner/components/lenra_menu_item.dart';
import 'package:lenra_ui_runner/components/lenra_toggle.dart';
import 'package:lenra_ui_runner/components/lenra_status_sticker.dart';
import 'package:lenra_ui_runner/components/lenra_flex.dart';
import '../lenra_component_builder.dart';
import '../lenra_ui_builder.dart';
import '../props_parser.dart';
import '../update_props_event.dart';
import 'lenra_button.dart';
import 'lenra_checkbox.dart';
import 'lenra_radio.dart';
import 'lenra_textfield.dart';
import 'lenra_image.dart';
import 'lenra_text.dart';

extension LenraComponentWrapperExt on LenraWrapper {
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
    'styledContainer': LenraStyledContainerBuilder(),
    'actionable': LenraActionableBuilder(),
    'dropdownButton': LenraDropdownButtonBuilder(),
    'flexible': LenraFlexibleBuilder(),
  };
}

class LenraWrapper extends StatefulWidget {
  final LenraUiBuilderState lenraUiBuilderState;
  final Map<String, dynamic> initialProperties;
  final String id;

  LenraWrapper(this.id, this.lenraUiBuilderState, this.initialProperties, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LenraWrapperState();
  }
}

class LenraWrapperState extends State<LenraWrapper> {
  //? This is the Json representation of the Lenra UIComponent
  late Map<Symbol, dynamic> parsedProps;
  late LenraComponentBuilder componentBuilder;

  @override
  void initState() {
    super.initState();
    parseProps(widget.initialProperties);
    widget.lenraUiBuilderState.updateWidgetStream.stream.listen((UpdatePropsEvent event) {
      if (event.id == widget.id) {
        updateProperties(event.properties);
      }
    });
  }

  void parseProps(Map<String, dynamic> properties) {
    String? type = properties['type'] as String?;
    if (type == null) throw "No type in component. It should never happen";
    if (!LenraComponentWrapperExt.componentsMapping.containsKey(type)) {
      throw "Componnent mapping does not handle type $type";
    }
    componentBuilder = LenraComponentWrapperExt.componentsMapping[type]!;
    parsedProps = Parser.parseProps(properties, componentBuilder.propsTypes);

    for (var childrenKey in componentBuilder.childrenKeys) {
      if (properties.containsKey(childrenKey)) {
        parsedProps[Symbol(childrenKey)] = widget.lenraUiBuilderState.getChildrenWidgets(properties[childrenKey]);
      }
    }

    for (var childKey in componentBuilder.childKeys) {
      if (properties.containsKey(childKey)) {
        parsedProps[Symbol(childKey)] = widget.lenraUiBuilderState.getChildWidget(properties[childKey]);
      }
    }
  }

  void updateProperties(Map<String, dynamic> properties) {
    setState(() {
      parseProps(properties);
    });
  }

  @override
  Widget build(BuildContext context) {
    return componentBuilder.build(parsedProps);
  }
}
