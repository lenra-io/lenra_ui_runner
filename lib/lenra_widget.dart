import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lenra_components/component/lenra_button.dart';
import 'package:lenra_components/layout/lenra_flex.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class LenraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetModel widgetModel = context.watch<WidgetModel>();
    Map<String, dynamic> ui = widgetModel.ui;
    List<dynamic> errors = widgetModel.errors;

    if (errors.isNotEmpty) {
      if (widgetModel.ui == {}) {
      } else {
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
              duration: Duration(minutes: 5),
              content: LenraFlex(
                direction: Axis.horizontal,
                children: [
                  Text("Error: " + errors[0]["message"] + " Code: " + errors[0]["code"].toString()),
                  Spacer(),
                  LenraButton(
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
    }

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return WidgetModel.parseJson(ui["root"]);
    }

    return WidgetModel.parseJson(ui);
  }
}
