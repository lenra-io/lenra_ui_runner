import 'components/lenra_wrapper.dart';

enum UIPatchOperation {
  add,
  addChild,
  remove,
  removeChild,
  replace,
  replaceChild,
}

extension UILenraOperationExtension on UIPatchOperation {
  UIPatchOperation toChildOperation() {
    switch (this) {
      case UIPatchOperation.add:
        return UIPatchOperation.addChild;
      case UIPatchOperation.remove:
        return UIPatchOperation.removeChild;
      case UIPatchOperation.replace:
        return UIPatchOperation.replaceChild;
      default:
        throw "Unhandled UI Patch Operation";
    }
  }
}

// Extends the String object to be able to transform it to UiPatchOperation
extension UILenraOperationStringExtension on String {
  UIPatchOperation toLenraUiPatchOperation() {
    switch (this) {
      case "add":
        return UIPatchOperation.add;
      case "remove":
        return UIPatchOperation.remove;
      case "replace":
        return UIPatchOperation.replace;
      default:
        throw "Unhandled UI Patch Operation";
    }
  }

  bool isInteger() {
    return int.tryParse(this) != null;
  }
}

class UiPatchEvent {
  String id;
  UIPatchOperation operation;
  List<String> propertyPathList;
  dynamic value;
  String? childIndex;
  String? childId;

  UiPatchEvent(
    this.id,
    this.operation,
    this.propertyPathList,
    this.value,
    this.childIndex,
    this.childId,
  );

/*

^(\/root(?:\/children\/\d+)*(?:\/children)?)((?:\/(?!children)(?:[\da-zA-Z_-])+)*)$

Breaks apart : 
^(\/root(?:\/children\/\d+)*(?:\/children)?)
  => Start with /root (mandatory)
  => can have 0 to N of :
    => /children/xx

((?:\/(?!children)(?:[\da-zA-Z_-])+)*)$
  => 0 to N of : 
   /<json_key>
   Excepting /children

 /root/children/0/children/1 /value
 /root/children/0/children/1 /listeners/onClick/code

^\/root(\/children\/\d+)+$ => /root/children/0/children/0
^\/root(\/children\/\d+)*\/children$ => 
/root/children/0/children
/root/children

*/

  factory UiPatchEvent.fromPatch(Map<String, dynamic> patch, Map<String, LenraWrapper> wrappers) {
    print(patch);
    UIPatchOperation operation = (patch['op'] as String).toLenraUiPatchOperation();
    dynamic value = patch['value'];
    String path = patch["path"];
    List<String> pathList = path.split("/")..removeAt(0);
    String childPath = "/${pathList.removeAt(0)}";
    bool isChildChange = false;
    bool stop = false;

    while (!stop && pathList.isNotEmpty) {
      LenraWrapper wrapper = wrappers[childPath]!;
      String type = wrapper.initialProperties["type"];
      List<String> childKeys = LenraComponentWrapperExt.componentsMapping[type]!.childKeys;
      List<String> childrenKeys = LenraComponentWrapperExt.componentsMapping[type]!.childrenKeys;
      String pathItem = pathList.elementAt(0);
      if (childKeys.contains(pathItem)) {
        if (pathList.length == 1) {
          stop = true;
          isChildChange = true;
        } else {
          childPath = "$childPath/${pathList.removeAt(0)}";
        }
      } else if (childrenKeys.contains(pathItem)) {
        if (pathList.length == 2) {
          stop = true;
          isChildChange = true;
        } else {
          childPath = "$childPath/${pathList.removeAt(0)}/${pathList.removeAt(0)}";
        }
      } else {
        stop = true;
      }
    }

    if (isChildChange) {
      String childId = "$childPath/${pathList.join("/")}";
      return UiPatchEvent(childPath, operation.toChildOperation(), pathList, value, pathList.last, childId);
    }

    return UiPatchEvent(childPath, operation, pathList, value, null, null);
  }
}
