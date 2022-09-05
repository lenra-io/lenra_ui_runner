import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:client_common/api/response_models/api_error.dart';
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
      res = LenraErrorPage(apiError: channelModel.error!);
    } else if (!channelModel.isInitialized) {
      res = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      res = LenraWidget<ApiError>(
        buildErrorPage: (BuildContext context, ApiError error) => AppErrorPage(apiError: error),
        showSnackBar: (BuildContext context, ApiError error) => {
          ScaffoldMessenger.of(context).showSnackBar(ApiErrorSnackBar(
            error: error,
            onPressAction: () => ScaffoldMessenger.of(context).clearSnackBars(),
            actionLabel: "Ok",
          )),
        },
      );
    }
    return Scaffold(body: res);
  }
}
