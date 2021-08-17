import 'package:flutter/widgets.dart';
import 'package:socket/lenra_channel.dart';

abstract class SocketModel extends ChangeNotifier {
  LenraChannel channel(String channelName, Map<String, dynamic> params);
}
