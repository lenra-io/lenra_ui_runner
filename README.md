# lenra_ui_runner

Implementation of the Lenra Component API in Dart with the Flutter framework.

## Lenra composant system
### LenraUiBuilder
It is a Stateful Widget which takes care of transforming the UI and the Patch into widget/properties usable : 
 - It takes in input both streams (UI and Patch)
 - It builds the components **LenraWrapper**.
 - It manages the modification of the property by the patch.
 - Notifies **LenraWrapper** when their properties change.
 - It knows all the properties and **LenraWrapper** of the app.
 - It displays the **LenraWrapper** corresponding to the "root" component of the UI.

### LenraWrapper
This is the "intelligent" parent component of all Lenra display components.
- It instantiates the display component according to type.
- It parses JSON properties into useful objects for the display component.