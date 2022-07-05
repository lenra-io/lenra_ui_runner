import 'package:lenra_ui_runner/lenra_ui_controller.dart';
import 'package:lenra_ui_runner/models/channel_model.dart';
import 'package:lenra_ui_runner/models/client_widget_model.dart';
import 'package:lenra_ui_runner/models/socket_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final String appName;

  const App({Key? key, required this.appName}) : super(key: key);

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<SocketModel, ChannelModel>(
          create: (context) => ChannelModel(socketModel: context.read<SocketModel>()),
          update: (_, socketModel, channelModel) {
            if (channelModel == null) {
              return ChannelModel(socketModel: socketModel);
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
        context.read<ChannelModel>().createChannel(widget.appName);
        (context.read<WidgetModel>() as ClientWidgetModel).setupListeners();

        return const LenraUiController();
      },
    );
  }
}
