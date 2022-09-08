import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/logic/render/render_box_adapter.dart';
import 'package:globe_flutter_android/core/logic/widgets/update_parent_data.dart';

import '../core.dart';

mixin SSWidget on Widget {}

class SSSingleChildRenderObjectElement extends SingleChildRenderObjectElement {
  SSSingleChildRenderObjectElement(SingleChildRenderObjectWidget widget)
      : super(widget);

  @override
  void attachRenderObject(newSlot) {
    super.attachRenderObject(newSlot);

    visitAncestorElements((element) {
      if (element is UpdateParentDataElement<ParentSSData>) {
        element.startParentData(renderObject);
      }
      return element.widget is! RenderObjectWidget;
    });
  }
}

abstract class SSMultiChildWidget extends MultiChildRenderObjectWidget
    with SSWidget {
  SSMultiChildWidget({Key? key, required List<Widget> children})
      : super(key: key, children: children);

  @override
  RenderMultiChildBoxSS createRenderObject(BuildContext context) {
    return RenderMultiChildBoxSS();
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMultiChildBoxSS renderObject) {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  SSMultiChildRenderObjectElement createElement() =>
      SSMultiChildRenderObjectElement(this);
}

class SSMultiChildRenderObjectElement extends MultiChildRenderObjectElement {
  SSMultiChildRenderObjectElement(MultiChildRenderObjectWidget widget)
      : assert(!debugChildrenHaveDuplicateKeys(widget, widget.children)),
        super(widget);

  @override
  void attachRenderObject(newSlot) {
    super.attachRenderObject(newSlot);

    visitAncestorElements((element) {
      if (element is UpdateParentDataElement<ParentSSData>) {
        element.startParentData(renderObject);
      }
      return element.widget is! RenderObjectWidget;
    });
  }
}
