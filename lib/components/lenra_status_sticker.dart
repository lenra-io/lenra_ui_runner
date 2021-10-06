import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_status_sticker.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import '../lenra_component_builder.dart';

// TODO generate this from annotation on LenraStatusSticker
class LenraStatusStickerBuilder extends LenraComponentBuilder<LenraApplicationStatusSticker> {
  @override
  LenraApplicationStatusSticker map({status}) {
    return LenraApplicationStatusSticker(status: status);
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "status": String,
    };
  }
}

class LenraApplicationStatusSticker extends StatelessWidget {
  final String status;

  static Color fromStatus(String status) {
    switch (status) {
      case "success":
        return LenraColorThemeData.lenraFunGreenBase;

      case "warning":
        return LenraColorThemeData.lenraFunYellowBase;

      case "error":
        return LenraColorThemeData.lenraFunRedBase;

      case "pending":
        return LenraColorThemeData.lenraFunBlueBase;

      default:
        return LenraColorThemeData.lenraFunGreenBase;
    }
  }

  LenraApplicationStatusSticker({
    required this.status,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraStatusSticker(
      color: LenraApplicationStatusSticker.fromStatus(status),
    );
  }
}
