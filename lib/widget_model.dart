import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

class ViewModel<E> extends ChangeNotifier {
  Map<String, dynamic>? _ui;
  E? _errors;

  Map<String, dynamic> get ui => hasUi() ? _ui! : {};
  E? get errors => _errors;

  bool hasError() {
    return _errors != null;
  }

  bool hasUi() {
    return _ui != null;
  }

  void replaceUi(Map<String, dynamic> ui) {
    _ui = ui;
    notifyListeners();
  }

  void patchUi(Iterable<Map<String, dynamic>> patches) {
    replaceUi(JsonPatch.apply(_ui, patches, strict: false));
  }

  void setErrors(E errors) {
    _errors = errors;
    notifyListeners();
  }
}
