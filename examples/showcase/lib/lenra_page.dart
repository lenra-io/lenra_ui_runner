import 'package:lenra_ui_runner/components/events/event.dart';

abstract class LenraPage {
  Map<String, dynamic> getUi(dynamic data);
  dynamic getData(Event event);
}