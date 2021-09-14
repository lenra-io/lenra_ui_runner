import 'package:lenra_components/theme/lenra_theme_data.dart';

class SizeHelper {
  static LenraComponentSize fromString(String size) {
    switch (size) {
      case "medium":
        return LenraComponentSize.medium;

      case "large":
        return LenraComponentSize.large;

      case "small":
        return LenraComponentSize.small;

      default:
        return LenraComponentSize.medium;
    }
  }
}
