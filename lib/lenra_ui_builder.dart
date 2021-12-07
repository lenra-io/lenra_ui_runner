import 'dart:async';

import 'package:flutter/material.dart';

// Parser le JSON et renvoyer un widget
// Le parser du json prend un composant JSON en entrée, récupérer le type et grâce à ça le builder dans le components mapping
// Exemple avec Flex,

class LenraUiBuilder extends StatefulWidget {
  final StreamController<Map<String, dynamic>> uiStream;
  final StreamController<Iterable<dynamic>> patchUiStream;

  LenraUiBuilder({required this.uiStream, required this.patchUiStream}) : super();

  @override
  State<StatefulWidget> createState() {
    return LenraUiBuilderState();
  }
}

class LenraUiBuilderState extends State<LenraUiBuilder> {
  @override
  void initState() {
    super.initState();
    widget.uiStream.stream.listen(replaceUi);
    widget.patchUiStream.stream.listen(patchUi);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void replaceUi(Map<String, dynamic> ui) {
    setState(() {
      // Sauvegarder l'ui qu'on lui passe
      // SetState this.ui = ui;
    });
  }

  void patchUi(Iterable<dynamic> patches) {
    // Patch (this.ui, patches)
  }

  @override
  Widget build(BuildContext context) {
    // Build this.ui récursivement

    return Container();
  }
}
