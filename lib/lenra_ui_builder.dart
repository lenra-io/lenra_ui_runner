import 'dart:async';

import 'package:flutter/material.dart';
import 'components/lenra_wrapper.dart';
import 'ui_patch.dart';
import 'update_props_event.dart';

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
  final Map<String, LenraWrapper> wrappers = {};
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
    registerChildrenOf(properties, path);
    registerChildOf(properties, path);
    registerProperties(path, properties);
    createWrapper(path, properties);
  }

  List<String> getChildrenKeys(Map<String, dynamic> properties) {
    String type = properties["type"] as String;
    if (!LenraComponentWrapperExt.componentsMapping.containsKey(type)) {
      throw "Componnent mapping does not handle type $type";
    }
    return LenraComponentWrapperExt.componentsMapping[type]!.childrenKeys;
  }

  List<String> getChildKeys(Map<String, dynamic> properties) {
    String type = properties["type"] as String;
    if (!LenraComponentWrapperExt.componentsMapping.containsKey(type)) {
      throw "Componnent mapping does not handle type $type";
    }
    return LenraComponentWrapperExt.componentsMapping[type]!.childKeys;
  }

  void registerChildrenOf(Map<String, dynamic> properties, String path) {
    List<String> childrenKeys = getChildrenKeys(properties);
    for (var childrenKey in childrenKeys) {
      registerChildrenKey(properties, childrenKey, path);
    }
  }

  void registerChildrenKey(
    Map<String, dynamic> properties,
    String childrenKey,
    String path,
  ) {
    List<String> newChildrenProps = registerChildren(properties[childrenKey] as List, childrenKey, path);
    properties[childrenKey] = newChildrenProps;
  }

  void registerChildOf(Map<String, dynamic> properties, String path) {
    List<String> childKeys = getChildKeys(properties);
    for (var childKey in childKeys) {
      registerChildKey(properties, childKey, path);
    }
  }

  void registerChildKey(
    Map<String, dynamic> properties,
    String childKey,
    String path,
  ) {
    properties[childKey] = registerChild(properties, childKey, path);
  }

  String registerChild(
    Map<String, dynamic> properties,
    String childKey,
    String path,
  ) {
    String id = "$path/$childKey";
    registerComponent(properties[childKey] as Map<String, dynamic>, id);
    return id;
  }

  List<String> registerChildren(
    List children,
    String childrenKey,
    String path,
  ) {
    int idx = 0;
    return children.map((dynamic child) {
      String id = "$path/$childrenKey/$idx";
      registerComponent(child as Map<String, dynamic>, id);
      idx++;
      return id;
    }).toList();
  }

  void registerProperties(String id, Map<String, dynamic> properties) {
    componentsProperties[id] = properties;
  }

  void replaceOperation(UiPatchEvent patch) {
    removeOperation(patch);
    addOperation(patch);
  }

  void addOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;
    var value = patch.value;

    if (patch.propertyPathList.last != "type") {
      List<String> childrenKeys = getChildrenKeys(properties);
      if (childrenKeys.contains(patch.propertyPathList.last)) {
        value = registerChildren(patch.value as List, patch.propertyPathList.last, patch.id);
      }

      List<String> childKeys = getChildKeys(properties);
      if (childKeys.contains(patch.propertyPathList.last)) {
        value = registerChild(patch.value as Map<String, dynamic>, patch.propertyPathList.last, patch.id);
      }
    }

    setProperty(
      properties,
      patch.propertyPathList,
      value,
    );
  }

  void removeOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;

    List<String> childrenKeys = getChildrenKeys(properties);
    if (childrenKeys.contains(patch.propertyPathList.last)) {
      List<String> children = properties[patch.propertyPathList.last];
      for (var child in children) {
        properties.remove(child);
        wrappers.remove(child);
      }
    }

    List<String> childKeys = getChildKeys(properties);
    if (childKeys.contains(patch.propertyPathList.last)) {
      String child = properties[patch.propertyPathList.last];
      properties.remove(child);
      wrappers.remove(child);
    }

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
    if (patch.childIndex == null || int.tryParse(patch.childIndex!) == null) {
      properties[patch.propertyPathList.first] = patch.childId;
    } else {
      if (patch.childIndex == '-') {
        (properties[patch.propertyPathList.first] as List?)?.add(patch.childId);
      } else {
        (properties[patch.propertyPathList.first] as List?)?.insert(int.parse(patch.childIndex!), patch.childId);
      }
    }
  }

  void removeChildOperation(UiPatchEvent patch) {
    Map<String, dynamic>? properties = componentsProperties[patch.id];
    if (properties == null) return;

    dynamic childId;
    if (patch.childIndex == null) {
      childId = properties.remove(patch.propertyPathList.first);
    } else {
      childId = (properties[patch.propertyPathList.first] as List?)?.removeAt(int.parse(patch.childIndex!));
    }
    wrappers.remove(childId);
  }

  void replaceChildOperation(UiPatchEvent patch) {
    removeChildOperation(patch);
    addChildOperation(patch);
  }

  void patchUi(Iterable<dynamic> patches) {
    var parsedPatches = patches.map((e) => UiPatchEvent.fromPatch(e as Map<String, dynamic>, wrappers));
    Set<String> widgetToUpdate = {};

    for (var patch in parsedPatches) {
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
      if (properties != null) {
        updateWidgetStream.add(UpdatePropsEvent(id, properties));
      }
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

  Widget getChildWidget(String id) {
    return wrappers[id]!;
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
