import 'dart:async';

import 'package:flutter/material.dart';
import 'components/lenra_wrapper.dart';
import 'ui_patch.dart';
import 'update_props_event.dart';

class LenraUiBuilder extends StatefulWidget {
  final StreamController<Map<String, dynamic>> uiStream;
  final StreamController<Iterable<UiPatchEvent>> patchUiStream;

  LenraUiBuilder({required this.uiStream, required this.patchUiStream}) : super();

  @override
  State<StatefulWidget> createState() {
    return LenraUiBuilderState();
  }
}

class LenraUiBuilderState extends State<LenraUiBuilder> {
  final Map<String, Widget> wrappers = {};
  final Map<String, Map<String, dynamic>> componentsProperties = {};
  final StreamController<UpdatePropsEvent> updateWidgetStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    widget.uiStream.stream.listen(replaceUi);
    widget.patchUiStream.stream.listen(patchUi);
  }

  @override
  void dispose() {
    updateWidgetStream.close();
    super.dispose();
  }

  void replaceUi(Map<String, dynamic> ui) {
    setState(() {
      registerComponent(ui["root"] as Map<String, dynamic>, "/root");
    });
  }

  void createWrapper(String id, Map<String, dynamic> properties) {
    LenraWrapper wrapper = LenraWrapper(
      id,
      this,
      properties,
      key: ValueKey(id),
    );
    wrappers[id] = wrapper;
  }

  void registerComponent(Map<String, dynamic> properties, String path) {
    if (properties.containsKey("children")) {
      List<String> newChildrenProps = registerChildren(properties["children"] as List, path);
      properties["children"] = newChildrenProps;
    }
    registerProperties(path, properties);
    createWrapper(path, properties);
  }

  List<String> registerChildren(List children, String path) {
    int idx = 0;
    return children.map((dynamic child) {
      String id = "$path/children/$idx";
      registerComponent(child as Map<String, dynamic>, id);
      idx++;
      return id;
    }).toList();
  }

  void registerProperties(String id, Map<String, dynamic> properties) {
    componentsProperties[id] = properties;
  }

  void replaceOperation(UiPatchEvent patch) {
    addOperation(patch);
  }

  void addOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;

    if (patch.propertyPathList.last == "children") {
      List<String> newChildrenProps = registerChildren(patch.value as List, patch.id);

      setProperty(
        properties,
        patch.propertyPathList,
        newChildrenProps,
      );
    } else {
      setProperty(
        properties,
        patch.propertyPathList,
        patch.value,
      );
    }
  }

  void removeOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;
    removeProperty(properties, patch.propertyPathList);
  }

  void removeProperty(Map<String, dynamic> properties, List<String> propertyPathList) {
    Map<String, dynamic> current = properties;
    for (int i = 0; i < propertyPathList.length - 1; i++) {
      current = current[propertyPathList[i]];
    }
    current.remove(propertyPathList.last);
  }

  void setProperty(Map<String, dynamic> properties, List<String> propertyPathList, dynamic value) {
    Map<String, dynamic> current = properties;
    for (int i = 0; i < propertyPathList.length - 1; i++) {
      current = current[propertyPathList[i]];
    }
    current[propertyPathList.last] = value;
  }

  void addChildOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;
    if (patch.childId == null) return;

    registerComponent(patch.value as Map<String, dynamic>, patch.childId!);
    (properties["children"] as List?)?.insert(patch.childIndex, patch.childId);
  }

  void removeChildOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;

    dynamic childId = (properties["children"] as List?)?.removeAt(patch.childIndex);
    wrappers.remove(childId);
  }

  void replaceChildOperation(UiPatchEvent patch) {
    removeChildOperation(patch);
    addChildOperation(patch);
  }

  void patchUi(Iterable<UiPatchEvent> patches) {
    Set<String> widgetToUpdate = {};

    for (var patch in patches) {
      widgetToUpdate.add(patch.id);

      switch (patch.operation) {
        case UIPatchOperation.replace:
          replaceOperation(patch);
          break;
        case UIPatchOperation.add:
          addOperation(patch);
          break;
        case UIPatchOperation.remove:
          removeOperation(patch);
          break;
        case UIPatchOperation.addChild:
          addChildOperation(patch);
          break;
        case UIPatchOperation.removeChild:
          removeChildOperation(patch);
          break;
        case UIPatchOperation.replaceChild:
          replaceChildOperation(patch);
          break;
      }
    }

    for (var id in widgetToUpdate) {
      Map<String, dynamic>? properties = componentsProperties[id];
      if (properties != null) updateWidgetStream.add(UpdatePropsEvent(id, properties));
    }
  }

  List<Widget> getChildrenWidgets(List<String> ids) {
    List<Widget> childrenWidgets = [];

    for (var id in ids) {
      if (wrappers.containsKey(id)) {
        childrenWidgets.add(wrappers[id]!);
      }
    }

    return childrenWidgets;
  }

  @override
  Widget build(BuildContext context) {
    Widget app;
    if (wrappers.containsKey("/root")) {
      app = wrappers["/root"]!;
    } else {
      app = Center(
        child: Text("No base component"),
      );
    }
    return Scaffold(
      body: app,
    );
  }
}
