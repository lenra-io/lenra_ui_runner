import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_components/theme/lenra_color_theme_data.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class LenraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetModel widgetModel = context.watch<WidgetModel>();
    Map<String, dynamic> ui = widgetModel.ui;
    List<Widget> errors = widgetModel.errors;

    if (errors.isNotEmpty) {
      // if (errors.length > 1) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: LenraFlex(
      //         direction: Axis.horizontal,
      //         children: [
      //           Text("Many errors occurs please contact developper"),
      //           Spacer(),
      //           LenraButton(
      //             onPressed: () {},
      //             text: "Contact developper",
      //           )
      //         ],
      //       ),
      //     ),
      //   );
      // } else {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(minutes: 2),
            backgroundColor: LenraColorThemeData.lenraCustomRed,
            content: LenraFlex(
              direction: Axis.horizontal,
              children: errors +
                  [
                    Spacer(),
                    LenraButton(
                      disabled: true,
                      type: LenraComponentType.secondary,
                      onPressed: () {},
                      text: "Contact developper",
                    )
                  ],
            ),
          ),
        );
      });

      // }

    }

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return WidgetModel.parseJson(ui["root"]);
    }

    return WidgetModel.parseJson(ui);
  }
}
