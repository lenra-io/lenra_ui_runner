import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/components/actionable/events/lenra_event.dart';
import 'package:lenra_ui_runner/props_parser.dart';

import "./test_helper.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';

void main() {
  test('Check parser working', () {
    expect(Parser.parseLenraComponentSize("large"), LenraComponentSize.large);
    expect(Parser.parseLenraComponentSize("medium"), LenraComponentSize.medium);
    expect(Parser.parseLenraComponentSize("small"), LenraComponentSize.small);
    expect(Parser.parseLenraComponentSize("lar"), LenraComponentSize.medium);
  });
}
