Everything starts with the `App` widget, which is used by other repositories to open applications. The `App` widget has parameters related to routing, including:
- `baseRoute`: the main route shown by default when the app is opened, typically `/`.
- `routeWidget`: the widget used to display the UI based on the current route. A pre-implemented widget called `LenraRoute` is used for this purpose (which will be explained later in this document).
- `navTo`: the callback used when the `@lenra:navTo` listener is called. This callback handles the redirection and receives a `context` and the `route` passed to the `@lenra:navTo` listener.
    
    For example, in the devtool, the redirection is handled as follows:
    ```flutter
    navTo: (context, route) {
        GoRouter.of(context).go(route);
    }
    ```

## Widget tree

The current widget tree consists of the following:


- `App`
    - `LenraSocket`
        - `LenraRoutes`
            - `LenraRoute` (the `routeWidget` of `App` to be exact)
                - `LenraWidget`

The `App` widget as mentioned above in the main widget used to open an app.

The `LenraSocket` handles the connection with the Phoenix socket (the server's WebSocket).

If the connection with the Phoenix socket is successful, the `LenraRoutes` widget is called. This widget opens a new channel called `routes` in the socket to receive the routes of the application from the app manifest. It also listens for the `navTo` event on this channel and calls the `LenraRouteModel.navTo()` when receiving it. 

Note: It appears that the result (i.e., the list of routes) of the connection to the `routes` channel is not used in `lenra_ui_runner`. Perhaps there could be some error handling implemented for cases when trying to redirect to an unknown route, to avoid sending a request to the server that would result in an error response.

If the connection to the `routes` channel is successful, the `routeWidget` of the `App` widget is called. The `routeWidget` is the `LenraRoute` widget, which is used as the default route widget. For example in the `devtool` :
```flutter
routeWidget: LenraRoute(
    "/${state.params['path']!}",
    // Use UniqueKey to make sure that the LenraRoute Widget is properly reloaded with the new route when navigating.
    key: UniqueKey(),
)
```

Where `state.params['path']` represents the current path in the application.

The `LenraRoute` widget opens a new channel with a name such as `route:/foo`, where `/foo` can be changed depending on the route that needs to be opened. It then listens for `onUi` and `onPatchUi` events to receive and patch the UI. Finally, the `LenraWidget` widget is called with the current UI in the state of `LenraRoute`.

## Event handling

When interacting with a component, such as a button, an event is sent via the `sendEvent` method to the furthest `LenraRouteIO` widget, which is instantiated in the build method of `LenraRoute`. This sends a message on the `route:/foo` channel with the event name as `run` and the corresponding listener's data in JSON format. The server responds with a new UI, which triggers a reload of the `LenraRoute` widget with the updated UI.

## TLDR 

1. `App` widget is used to open the app and has parameters related to routing.
2. `LenraSocket` handles the connection with the server's WebSocket (Phoenix socket).
3. If the connection with the Phoenix socket is successful, `LenraRoutes` widget is called, which opens a new channel (`routes`) in the socket to receive app routes from the app manifest.
4. `LenraRoutes` listens for `navTo` event on the `routes` channel and calls `LenraRouteModel.navTo()` when received.
5. If the connection to the `routes` channel is successful, the `routeWidget` of `App` widget is called, which is the `LenraRoute` widget used as the default route widget.
6. `LenraRoute` opens a new channel with a name such as `route:/foo`, depending on the current route, and listens for `onUi` and `onPatchUi` events to receive and patch the UI.
7. `LenraWidget` is called with the current UI in the state of `LenraRoute`.
8. When interacting with a component, an event is sent via `sendEvent` method to the furthest `LenraRouteIO` widget, which sends a message on the `route:/foo` channel with the event name and data.
9. The server responds with a new UI, triggering a reload of `LenraRoute` widget with the updated UI.