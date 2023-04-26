import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/children_widgets.dart';
import 'package:lenra_ui_runner/lenra_component_builder.dart';

class LenraCarouselBuilder extends LenraComponentBuilder<LenraApplicationCarousel> {
  @override
  LenraApplicationCarousel map({
    children,
    options,
  }) {
    return LenraApplicationCarousel(
      children: children,
      options: options,
    );
  }

  @override
  Map<String, Type> get propsTypes {
    return {
      "options": CarouselOptions,
      "children": ChildrenWidgets,
    };
  }
}

class LenraApplicationCarousel extends StatelessWidget {
  final List<Widget> children;
  final CarouselOptions? options;

  LenraApplicationCarousel({
    required this.children,
    required this.options,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: children,
      options: options ?? CarouselOptions(),
    );
  }
}
