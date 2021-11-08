import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import '../lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraApplicationImage> {
  @override
  LenraApplicationImage map({
    path,
    height,
    width,
    alignment,
    centerSlice,
    errorBuilder,
    excludeFromSemantics,
    filterQuality,
    fit,
    frameBuilder,
    gaplessPlayback,
    isAntiAlias,
    loadingBuilder,
    opacity,
    repeat,
    semanticLabel,
  }) {
    return LenraApplicationImage(
      path: path,
      width: width,
      height: height,
      alignment: alignment,
      centerSlice: centerSlice,
      errorBuilder: errorBuilder,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      loadingBuilder: loadingBuilder,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "path": String,
      "width": double,
      "height": double,
    };
  }
}

class LenraApplicationImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final AlignmentGeometry alignment;
  final Rect? centerSlice;
  final ImageErrorWidgetBuilder? errorBuilder;
  final bool excludeFromSemantics;
  final FilterQuality filterQuality;
  final BoxFit? fit;
  final ImageFrameBuilder? frameBuilder;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final ImageLoadingBuilder? loadingBuilder;
  final Animation<double>? opacity;
  final ImageRepeat repeat;
  final String? semanticLabel;

  LenraApplicationImage({
    required this.path,
    required this.height,
    required this.width,
    required this.alignment,
    required this.centerSlice,
    required this.errorBuilder,
    required this.excludeFromSemantics,
    required this.filterQuality,
    required this.fit,
    required this.frameBuilder,
    required this.gaplessPlayback,
    required this.isAntiAlias,
    required this.loadingBuilder,
    required this.opacity,
    required this.repeat,
    required this.semanticLabel,
  }) : super();

  @override
  Widget build(BuildContext context) {
    var model = context.read<LenraApplicationModel>();

    return Image.network(
      "${model.httpEndpoint}/api/apps/${model.applicationName}/resources/$path?token=${model.accessToken}",
      height: height,
      width: width,
      alignment: alignment,
      centerSlice: centerSlice,
      errorBuilder: errorBuilder,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      loadingBuilder: loadingBuilder,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
    );
  }
}
