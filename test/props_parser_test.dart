import 'package:lenra_components/lenra_components.dart';
import 'package:lenra_ui_runner/props_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Check parser working', () {
    expect(Parser.parseLenraComponentSize("large"), LenraComponentSize.large);
    expect(Parser.parseLenraComponentSize("medium"), LenraComponentSize.medium);
    expect(Parser.parseLenraComponentSize("small"), LenraComponentSize.small);
    expect(Parser.parseLenraComponentSize("lar"), LenraComponentSize.medium);
  });
}
