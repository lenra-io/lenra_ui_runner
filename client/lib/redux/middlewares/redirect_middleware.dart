import 'package:fr_lenra_client/navigation/lenra_navigator.dart';
import 'package:fr_lenra_client/redux/actions/push_route_action.dart';
import 'package:fr_lenra_client/redux/states/app_state.dart';
import 'package:redux/redux.dart';

/// This middleware handles redirection actions.
///
/// When a [PushRouteAction] action is captured by this middleware, it redirects the client to the new route.
void redirectMiddleware(
  Store<AppState> store,
  PushRouteAction action,
  NextDispatcher next,
) {
  if (action.removeStack) {
    LenraNavigator.navigatorKey.currentState.pushReplacementNamed(
      action.routeName,
      arguments: action.arguments,
    );
  } else {
    LenraNavigator.navigatorKey.currentState.pushNamed(
      action.routeName,
      arguments: action.arguments,
    );
  }
}
