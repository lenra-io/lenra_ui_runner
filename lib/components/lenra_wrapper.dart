import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/container/lenra_flex.dart';

import '../lenra_component_builder.dart';
import '../lenra_ui_builder.dart';
import '../props_parser.dart';
import '../update_props_event.dart';
import 'actionable/lenra_button.dart';
import 'actionable/lenra_checkbox.dart';
import 'actionable/lenra_radio.dart';
import 'actionable/lenra_textfield.dart';
import 'container/lenra_container.dart';
import 'lenra_image.dart';
import 'lenra_text.dart';

extension LenraComponentWrapperExt on LenraWrapper {
  static final Map<String, LenraComponentBuilder> componentsMapping = {
    'container': LenraContainerBuilder(),
    'text': LenraTextBuilder(),
    'textfield': LenraTextfieldBuilder(),
    'button': LenraButtonBuilder(),
    'checkbox': LenraCheckboxBuilder(),
    'image': LenraImageBuilder(),
    'radio': LenraRadioBuilder(),
    'flex': LenraFlexBuilder(),
    // 'table': LenraTableBuilder(),
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
    this.parseProps(widget.initialProperties);
    this.widget.lenraUiBuilderState.updateWidgetStream.stream.listen((UpdatePropsEvent event) {
      if (event.id == widget.id) {
        this.updateProperties(event.properties);
      }
    });
  }

  void parseProps(Map<String, dynamic> properties) {
    String? type = properties['type'] as String?;
    if (type == null) throw "No type in component. It should never happen";
    if (!LenraComponentWrapperExt.componentsMapping.containsKey(type))
      throw "Componnent mapping does not handle type $type";
    this.componentBuilder = LenraComponentWrapperExt.componentsMapping[type]!;
    this.parsedProps = Parser.parseProps(properties, this.componentBuilder.propsTypes);

    if (properties["children"] != null) {
      this.parsedProps[Symbol("children")] = widget.lenraUiBuilderState.getChildrenWidgets(properties["children"]);
    }
  }

  void updateProperties(Map<String, dynamic> properties) {
    setState(() {
      this.parseProps(properties);
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.componentBuilder.build(parsedProps);
  }
}
