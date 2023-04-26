import 'package:flutter/widgets.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/on_changed_event.dart';
import 'package:lenra_ui_runner/io_components/lenra_route.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';
import 'package:lenra_ui_runner/components/listeners/listener.dart' as lenra;
import 'package:provider/provider.dart';

// TODO : generate this from annotation on LenraForm
class LenraFormBuilder extends LenraComponentBuilder<LenraApplicationForm> {
  @override
  LenraApplicationForm map({
    child,
    onSubmit,
  }) {
    return LenraApplicationForm(
      child: child,
      onSubmit: onSubmit,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "child": Widget,
      "onSubmit": lenra.Listener,
    };
  }
}

class LenraApplicationForm extends StatelessWidget {
  final Widget child;
  final lenra.Listener? onSubmit;

  LenraApplicationForm({
    required this.child,
    required this.onSubmit,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormProvider(context: context, onSubmit: onSubmit),
      child: child,
    );
  }
}

/// The FormProvider that handles field values for the form widget
///
/// It facilitates the definition and retrieval of form field values
class FormProvider extends ChangeNotifier {
  Map<String, dynamic> formFieldValues = {};
  lenra.Listener? onSubmit;
  BuildContext context;

  FormProvider({required this.context, this.onSubmit});

  /// Calling this method will dispatch an event that contains form field values to the Lenra Widget system.
  void submitForm() {
    if (onSubmit != null) {
      EventManager.of(context).sendEvent(OnChangedEvent(code: onSubmit!.code, data: ValueData(formFieldValues))).then(
            //implement loading
            (value) => null,
          );
    }
  }

  void initFormFieldValue(String name, dynamic value) {
    formFieldValues[name] = value;
  }

  void setFormFieldValue(String name, dynamic value) {
    formFieldValues[name] = value;
    notifyListeners();
  }
}
