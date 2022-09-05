import 'package:client_common/models/user_application_model.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/lenra_application_model.dart';
import 'package:lenra_ui_runner/lenra_ui_controller.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/client_widget_model.dart';
import 'package:lenra_ui_runner/models/context_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  /// The name of the Lenra application.
  final String appName;

  /// The URL of the Lenra server.
  final String httpEndpoint;

  /// The access token to use for the Lenra server.
  final String accessToken;

  const App({Key? key, required this.appName, required this.httpEndpoint, required this.accessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContextModel>(create: (context) => ContextModel()),
        ChangeNotifierProvider<UserApplicationModel>(create: (context) => UserApplicationModel()),
        ChangeNotifierProvider<LenraApplicationModel>(
          create: (context) => LenraApplicationModel(httpEndpoint, appName, accessToken),
        ),
        ChangeNotifierProxyProvider2<SocketModel, ContextModel, ChannelModel>(
          create: (context) =>
              ChannelModel(socketModel: context.read<SocketModel>(), contextModel: context.read<ContextModel>()),
          update: (_, socketModel, contextModel, channelModel) {
            if (channelModel == null) {
              return ChannelModel(socketModel: socketModel, contextModel: contextModel);
            }
            return channelModel.update(socketModel);
          },
        ),
        ChangeNotifierProxyProvider<ChannelModel, WidgetModel>(
          create: (context) => ClientWidgetModel(channelModel: context.read<ChannelModel>()),
          update: (_, channelModel, clientWidgetModel) => clientWidgetModel!,
        ),
      ],
      builder: (BuildContext context, _) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<ContextModel>().mediaQueryData = MediaQuery.of(context);
          //The model calls are in the postframe callback because the mediaquerydata is not set until the first frame
          context.read<ChannelModel>().createChannel(appName);
          (context.read<WidgetModel>() as ClientWidgetModel).setupListeners();
        });

        return NotificationListener<Event>(
          onNotification: (Event event) => context.read<ChannelModel>().handleNotifications(event),
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => const LenraUiController(),
              ),
            ],
          ),
        );
      },
    );
  }
}
