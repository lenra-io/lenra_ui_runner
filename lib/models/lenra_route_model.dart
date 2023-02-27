import 'package:flutter/widgets.dart';

class LenraRouteModel extends ChangeNotifier {
  Widget routeWidget;
  final String baseRoute;
  final void Function(BuildContext, String) navTo;

  LenraRouteModel({
    required this.routeWidget,
    required this.baseRoute,
    required this.navTo,
  });

  void goTo(BuildContext context, String goToRoute) {
    print(baseRoute + goToRoute);
    navTo(context, baseRoute + goToRoute);
  }

  LenraRouteModel update(Widget newRouteWidget) {
    routeWidget = newRouteWidget;
    notifyListeners();
    return this;
  }
}