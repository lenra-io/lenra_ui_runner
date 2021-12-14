abstract class LenraComponentBuilder<T> {
  T build(Map<Symbol, dynamic> parsedProps) {
    return Function.apply(map, [], parsedProps);
  }

  T map();

  Map<String, Type> get propsTypes;
}
