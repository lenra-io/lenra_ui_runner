import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:showcase/lenra_page.dart';

class LenraMenuPage extends LenraPage{
  @override
  Map<String, dynamic> getUi(dynamic data) {
    return {
      "root": {
        "type": "flex",
        "children": [
          {
            "type": "menu",
            "children": [
              {
                "type": "menuItem",
                "text": "First",
                "isSelected": data,
                "disabled": true,
                "icon": {"type": "icon", "value": "ac_unit"},
                "onPressed": {
                  "code": "first",
                }
              },
              {
                "type": "menuItem",
                "text": "Second",
                "isSelected": data,
                "onPressed": {
                  "code": "second",
                }
              },
              {
                "type": "menuItem",
                "text": "Third",
                "isSelected": data,
                "icon": {"type": "icon", "value": "unarchive"},
                "onPressed": {
                  "code": "third",
                }
              },
              {
                "type": "menuItem",
                "text": "Fourth",
                "isSelected": data,
                "icon": {"type": "icon", "value": "aod"},
                "onPressed": {
                  "code": "fourth",
                }
              }
            ]
          },
        ]
      }
    };
  }

  @override
  dynamic getData(Event event) {
    print(event.code);
    return false;
  }
}
