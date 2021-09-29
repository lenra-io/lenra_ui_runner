abstract class LenraComponentBuilder<T> {
  T build(Map<Symbol, dynamic> parsedProps) {
    return Function.apply(map, [], parsedProps);
  }

  T map();

  Map<String, String> get propsTypes;
  List<String> get childrenKeys {
    return [];
  }

  List<String> get childKeys {
    return [];
  }
}
