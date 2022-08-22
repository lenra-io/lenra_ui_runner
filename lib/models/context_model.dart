import 'package:flutter/widgets.dart';

class ContextModel extends ChangeNotifier {
  Size screenSize = const Size(0, 0);

  set mediaQueryData(MediaQueryData mediaQuery) {
    screenSize = mediaQuery.size;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'screenSize': {
        'width': screenSize.width,
        'height': screenSize.height,
      }
    };
  }
}