import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraImage> {
  @override
  LenraImage map({
    src,
    width,
    height,
    alignment,
    centerSlice,
    errorPlaceHolder,
    loadingPlaceHolder,
    excludeFromSemantics,
    filterQuality,
    fit,
    framePlaceHolder,
    gaplessPlayback,
    isAntiAlias,
    opacity,
    repeat,
    semanticLabel,
  }) {
    return LenraImage(
      src: src,
      width: width,
      height: height,
      alignment: alignment,
      centerSlice: centerSlice,
      errorPlaceHolder: errorPlaceHolder,
      loadingPlaceHolder: loadingPlaceHolder,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      framePlaceHolder: framePlaceHolder,
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
      "src": String,
      "width": double,
      "height": double,
      "alignment": AlignmentGeometry,
      "centerSlice": Rect,
      "excludeFromSemantics": bool,
      "filterQuality": FilterQuality,
      "fit": BoxFit,
      "framePlaceHolder": Widget,
      "errorPlaceHolder": Widget,
      "loadingPlaceHolder": Widget,
      "gaplessPlayback": bool,
      "isAntiAlias": bool,
      "opacity": Animation,
      "repeat": ImageRepeat,
      "semanticLabel": String,
    };
  }
}

class LenraImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Rect? centerSlice;
  final Widget? errorPlaceHolder;
  final Widget? loadingPlaceHolder;
  final bool? excludeFromSemantics;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final Widget? framePlaceHolder;
  final bool? gaplessPlayback;
  final bool? isAntiAlias;
  final Animation<double>? opacity;
  final ImageRepeat? repeat;
  final String? semanticLabel;

  LenraImage({
    required this.src,
    required this.width,
    required this.height,
    required this.alignment,
    required this.centerSlice,
    required this.errorPlaceHolder,
    required this.loadingPlaceHolder,
    required this.excludeFromSemantics,
    required this.filterQuality,
    required this.fit,
    required this.framePlaceHolder,
    required this.gaplessPlayback,
    required this.isAntiAlias,
    required this.opacity,
    required this.repeat,
    required this.semanticLabel,
  }) : super();

  @override
  Widget build(BuildContext context) {
    String src;

    if (this.src.startsWith("http://") || this.src.startsWith("https://")) {
      src = this.src;
    } else {
      var model = context.read<LenraApplicationModel>();

      src = "${model.httpEndpoint}/api/apps/${model.applicationName}/resources/${this.src}?token=${model.accessToken}";
    }

    return Image.network(
      src,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      centerSlice: centerSlice,
      errorBuilder: errorPlaceHolder == null ? null : (_, __, ___) => errorPlaceHolder!,
      excludeFromSemantics: excludeFromSemantics ?? false,
      filterQuality: filterQuality ?? FilterQuality.low,
      fit: fit,
      frameBuilder: framePlaceHolder == null ? null : (_, __, ___, ____) => framePlaceHolder!,
      gaplessPlayback: gaplessPlayback ?? false,
      isAntiAlias: isAntiAlias ?? false,
      loadingBuilder: loadingPlaceHolder == null ? null : (_, __, ___) => loadingPlaceHolder!,
      opacity: opacity,
      repeat: repeat ?? ImageRepeat.noRepeat,
      semanticLabel: semanticLabel,
    );
  }
}
