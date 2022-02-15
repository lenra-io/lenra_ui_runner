import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class LenraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetModel widgetModel = context.watch<WidgetModel>();
    Map<String, dynamic> ui = widgetModel.ui;
    List<Widget> errors = widgetModel.errors;

    if (errors.isNotEmpty) {
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
                    //Should consider using api route to notify dev
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
    }

    if (ui.keys.contains("root") && ui.keys.length == 1) {
      return WidgetModel.parseJson(ui["root"]);
    }

    return WidgetModel.parseJson(ui);
  }
}
