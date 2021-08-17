import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_image.dart';

void main() {
  test('LenraImage test', () {
    LenraImage component = LenraImage(
      path: "test.jpeg",
    );
    expect(component is LenraImage, true);
  });
}
