import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraImage
class LenraImageBuilder extends LenraComponentBuilder<LenraApplicationImage> {
  @override
  LenraApplicationImage map({
    path,
    fromNetwork,
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
      fromNetwork: fromNetwork,
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
      "fromNetwork": bool,
      "width": double,
      "height": double,
      "alignment": AlignmentGeometry,
      "centerSlice": Rect,
      "excludeFromSemantics": bool,
      "filterQuality": FilterQuality,
      "fit": BoxFit,
      "frameBuilder": ImageFrameBuilder,
      "gaplessPlayback": bool,
      "isAntiAlias": bool,
      "opacity": Animation,
      "repeat": ImageRepeat,
      "semanticLabel": String,
    };
  }

  @override
  List<String> get childKeys {
    return ["errorBuilder", "loadingBuilder"];
  }
}

class LenraApplicationImage extends StatelessWidget {
  final String path;
  final bool? fromNetwork;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Rect? centerSlice;
  final Widget? errorBuilder;
  final Widget? loadingBuilder;
  final bool? excludeFromSemantics;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final ImageFrameBuilder? frameBuilder;
  final bool? gaplessPlayback;
  final bool? isAntiAlias;
  final Animation<double>? opacity;
  final ImageRepeat? repeat;
  final String? semanticLabel;

  LenraApplicationImage({
    required this.path,
    required this.fromNetwork,
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

  Widget onError(BuildContext context, Object error, StackTrace? stackTrace) {
    // TODO: Dispatch an event and return a widget.
    // if (errorBuilder != null) {
    //   OnChangedEvent(code: errorBuilder!.code, data: ValueData(error.toString())).dispatch(context);
    // }

    // TODO: Create a default ImageError widget and return it when errorBuilder is null.
    return errorBuilder ?? Container();
  }

  Widget loading(BuildContext context, Widget child, ImageChunkEvent? event) {
    // TODO: Dispatch an event and return a widget.
    // TODO: Create a default ImageLoader widget and return it when loadingBuilder is null.
    return loadingBuilder ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<LenraApplicationModel>();

    String path = fromNetwork != null && fromNetwork!
        ? this.path
        : "${model.httpEndpoint}/api/apps/${model.applicationName}/resources/${this.path}?token=${model.accessToken}";

    return Image.network(
      path,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      centerSlice: centerSlice,
      errorBuilder: (context, error, stackTrace) => onError(context, error, stackTrace),
      excludeFromSemantics: excludeFromSemantics ?? false,
      filterQuality: filterQuality ?? FilterQuality.low,
      fit: fit,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback ?? false,
      isAntiAlias: isAntiAlias ?? false,
      loadingBuilder: (context, child, event) => loading(context, child, event),
      opacity: opacity,
      repeat: repeat ?? ImageRepeat.noRepeat,
      semanticLabel: semanticLabel,
    );
  }
}
