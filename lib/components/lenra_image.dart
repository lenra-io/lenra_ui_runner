import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'lenra_component.dart';
import '../lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraApplicationImage> {
  LenraApplicationImage map({path, backgroundColor, height, width}) {
    return LenraApplicationImage(path: path, width: width, height: height);
  }

  Map<String, String> get propsTypes {
    return {
      "path": "String",
      "width": "double",
      "height": "double",
    };
  }
}

class LenraApplicationImage extends StatelessLenraComponent {
  final String path;
  // TODO: For future features add handling for image resizing
  final double? height;
  final double? width;

  LenraApplicationImage({
    required this.path,
    this.height,
    this.width,
  }) : super();

  @override
  Widget build(BuildContext context) {
    var model = context.read<LenraApplicationModel>();

    return Image.network(
      "${model.httpEndpoint}/api/apps/${model.applicationName}/resources/${this.path}?token=${model.accessToken}",
    );
  }
}
