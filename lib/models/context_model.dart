import 'package:flutter/widgets.dart';

class ContextModel extends ChangeNotifier {
  Size screenSize = const Size(0, 0);

  ContextModel(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
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
