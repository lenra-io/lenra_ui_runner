import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraApplicationImage> {
  @override
  LenraApplicationImage map({
    path,
    width,
    height,
    alignment,
    centerSlice,
    errorBuilder,
    loadingBuilder,
    excludeFromSemantics,
    filterQuality,
    fit,
    frameBuilder,
    gaplessPlayback,
    isAntiAlias,
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
      loadingBuilder: loadingBuilder,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
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
      "alignment": AlignmentGeometry,
      "centerSlice": Rect,
      "excludeFromSemantics": bool,
      "filterQuality": FilterQuality,
      "fit": BoxFit,
      "frameBuilder": Widget,
      "errorBuilder": Widget,
      "loadingBuilder": Widget,
      "gaplessPlayback": bool,
      "isAntiAlias": bool,
      "opacity": Animation,
      "repeat": ImageRepeat,
      "semanticLabel": String,
    };
  }
}

class LenraApplicationImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Rect? centerSlice;
  final Widget? errorBuilder;
  final Widget? loadingBuilder;
  final bool? excludeFromSemantics;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final Widget? frameBuilder;
  final bool? gaplessPlayback;
  final bool? isAntiAlias;
  final Animation<double>? opacity;
  final ImageRepeat? repeat;
  final String? semanticLabel;

  LenraApplicationImage({
    required this.path,
    required this.width,
    required this.height,
    required this.alignment,
    required this.centerSlice,
    required this.errorBuilder,
    required this.loadingBuilder,
    required this.excludeFromSemantics,
    required this.filterQuality,
    required this.fit,
    required this.frameBuilder,
    required this.gaplessPlayback,
    required this.isAntiAlias,
    required this.opacity,
    required this.repeat,
    required this.semanticLabel,
  }) : super();

  @override
  Widget build(BuildContext context) {
    String path;

    if (this.path.startsWith("http://") || this.path.startsWith("https://")) {
      path = this.path;
    } else {
      var model = context.read<LenraApplicationModel>();

      path =
          "${model.httpEndpoint}/api/apps/${model.applicationName}/resources/${this.path}?token=${model.accessToken}";
    }

    return Image.network(
      path,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      centerSlice: centerSlice,
      errorBuilder: errorBuilder == null ? null : (_, __, ___) => errorBuilder!,
      excludeFromSemantics: excludeFromSemantics ?? false,
      filterQuality: filterQuality ?? FilterQuality.low,
      fit: fit,
      frameBuilder: frameBuilder == null ? null : (_, __, ___, ____) => frameBuilder!,
      gaplessPlayback: gaplessPlayback ?? false,
      isAntiAlias: isAntiAlias ?? false,
      loadingBuilder: loadingBuilder == null ? null : (_, __, ___) => loadingBuilder!,
      opacity: opacity,
      repeat: repeat ?? ImageRepeat.noRepeat,
      semanticLabel: semanticLabel,
    );
  }
}
