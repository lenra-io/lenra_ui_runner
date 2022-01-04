# lenra_ui_runner

Implementation of the Lenra Component API in Dart with the Flutter framework.

## Lenra component system

### LenraUiBuilder
It is a Stateful Widget which takes care of transforming the UI and Patchs into usable widget/properties : 

 - It takes both streams (UI and Patch) as input 

 - It builds the components **LenraWrapper**.
 - It manages the modification of the properties by the patch.

 - Notifies **LenraWrapper** when their properties change.
 - It knows all the properties and **LenraWrapper** of the app.
 - It displays the **LenraWrapper** corresponding to the "root" component of the UI.

### LenraWrapper
This is the "smart" parent component of all Lenra display components.

- It instantiates the display component according to the type.

- It parses JSON properties into useful objects for the display component.

## Running tests
### Prerequisites

You need to generate the mockito mocks for the tests to properly run. This can be done by running the following command :

```bash
flutter pub run build_runner build
```