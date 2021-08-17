import 'package:flutter/material.dart';
import 'components/lenra_component.dart';
import 'lenra_component_builder.dart';
import 'package:lenra_components/lenra_image.dart';

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
    // TODO: manage an application model to get the datas
    var authModel = context.read<AuthModel>();
    String? appName = context.read<UserApplicationModel>().currentApp;

    return Image.network(
      "${Config.instance.httpEndpoint}/api/apps/$appName/resources/${this.path}?token=${authModel.accessToken}",
    );
  }
}
