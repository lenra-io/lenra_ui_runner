import 'package:lenra_components/theme/lenra_theme_data.dart';

class TypeHelper {
  static LenraComponentType fromString(String? type) {
    switch (type) {
      case "primary":
        return LenraComponentType.primary;

      case "secondary":
        return LenraComponentType.secondary;

      case "tertiary":
        return LenraComponentType.tertiary;

      default:
        return LenraComponentType.primary;
    }
  }
}
