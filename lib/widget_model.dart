import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

class WidgetModel extends ChangeNotifier {
  bool error = false;
  Map<String, dynamic> _ui = {};
  List<Widget> _errors = [];

  Map<String, dynamic> get ui => _ui;

  List<Widget> get errors => _errors;

  void replaceUi(Map<String, dynamic> ui) {
    _ui = ui;
    notifyListeners();
  }

  void patchUi(Iterable<Map<String, dynamic>> patches) {
    replaceUi(JsonPatch.apply(_ui, patches, strict: false));
  }

  void appErrors(List<Widget> errors) {
    error = true;
    _errors = errors;
    notifyListeners();
  }
}
