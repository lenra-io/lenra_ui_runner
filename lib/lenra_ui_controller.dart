import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/lenra_application/api_error_snack_bar.dart';
import 'package:client_common/lenra_application/app_error_page.dart';
import 'package:client_common/lenra_application/lenra_error_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';
import 'package:provider/provider.dart';

class LenraUiController extends StatelessWidget {
  const LenraUiController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChannelModel channelModel = context.watch<ChannelModel>();
    Widget res;
    if (channelModel.hasError) {
      res = LenraErrorPage(apiErrors: channelModel.errors!);
    } else if (!channelModel.isInitialized) {
      res = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      res = LenraWidget<ApiErrors>(
        buildErrorPage: (BuildContext context, ApiErrors errors) => AppErrorPage(apiErrors: errors),
        showSnackBar: (BuildContext context, ApiErrors errors) => {
          ScaffoldMessenger.of(context).showSnackBar(ApiErrorSnackBar(
            errors: errors,
            onPressAction: () => ScaffoldMessenger.of(context).clearSnackBars(),
            actionLabel: "Ok",
          )),
        },
      );
    }
    return NotificationListener(
      onNotification: (Event event) => context.read<ChannelModel>().handleNotifications(event),
      child: Scaffold(body: res),
    );
  }
}
