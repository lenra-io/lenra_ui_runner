import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';


class LenraCarouselBuilder extends LenraComponentBuilder<LenraApplicationCarousel> {
  @override
  LenraApplicationCarousel map({
    children,
  }) {
    return LenraApplicationCarousel(
      children: children,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationCarousel extends StatelessWidget {
  final List<Widget> children;

  LenraApplicationCarousel({
    required this.children,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: children,
      options: CarouselOptions(),
    );
  }
}
