import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:globe_flutter_android/core/logic/widgets/update_parent_data.dart';
import 'package:globe_flutter_android/core/logic/widgets/illustration.dart';

import '../core.dart';

class SSTransform {
  SSVector rotate;
  SSVector translate;
  SSVector scale;

  SSTransform(
      {this.rotate = SSVector.zero,
      this.translate = SSVector.zero,
      this.scale = SSVector.identity});
}

class SSPositioned extends SSUpdateParentDataWidget<ParentSSData>
    with SSWidget {
  const SSPositioned({
    Key? key,
    this.scale = SSVector.identity,
    this.translate = SSVector.zero,
    this.rotate = SSVector.zero,
    required Widget child,
  }) : super(key: key, child: child);

  SSPositioned.scale({
    Key? key,
    double x = 1,
    double y = 1,
    double z = 1,
    required Widget child,
  })  : scale = SSVector(x, y, z),
        rotate = SSVector.zero,
        translate = SSVector.zero,
        super(key: key, child: child);

  SSPositioned.translate({
    Key? key,
    double x = 0,
    double y = 0,
    double z = 0,
    required Widget child,
  })  : scale = SSVector.identity,
        rotate = SSVector.zero,
        translate = SSVector(x, y, z),
        super(key: key, child: child);

  SSPositioned.rotate({
    Key? key,
    double x = 0,
    double y = 0,
    double z = 0,
    required Widget child,
  })  : scale = SSVector.identity,
        rotate = SSVector(x, y, z),
        translate = SSVector.zero,
        super(key: key, child: child);

  final SSVector translate;
  final SSVector rotate;
  final SSVector scale;

  @override
  void updateParentData(RenderObject renderObject, SSPositioned oldWidget,
      SSTransform transform) {
    assert(renderObject.parentData is ParentSSData);

    final ParentSSData parentData = renderObject.parentData as ParentSSData;
    bool needsLayout = false;
    //  assert(parentData.transforms.contains(transform));
    transform.scale = scale;
    transform.rotate = rotate;
    transform.translate = translate;

    if (scale != oldWidget.scale ||
        rotate != oldWidget.rotate ||
        translate != oldWidget.translate) {
      needsLayout = true;
    }

    if (renderObject is RenderMultiChildBoxSS) {
      RenderBox? child = renderObject.firstChild;

      while (child != null) {
        final ParentSSData childParentData = child.parentData as ParentSSData;
        updateParentData(child, oldWidget, transform);
        child = childParentData.nextSibling;
      }
    }

    if (needsLayout) {
      renderObject.markNeedsLayout();
      AbstractNode? targetParent = renderObject.parent;

      while (targetParent is RenderBox) {
        targetParent.markNeedsLayout();
        targetParent = targetParent.parent;
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => SSWidget;

  @override
  void startParentData(RenderObject renderObject, SSTransform transform) {
    assert(renderObject.parentData is ParentSSData);
    final ParentSSData parentData = renderObject.parentData as ParentSSData;
    // print('crate matrix');
    transform.scale = scale;
    transform.translate = translate;
    transform.rotate = rotate;

    parentData.transforms.add(transform);

    if (renderObject is RenderMultiChildBoxSS) {
      RenderBox? child = renderObject.firstChild;

      while (child != null) {
        final ParentSSData childParentData = child.parentData as ParentSSData;
        startParentData(child, transform);
        child = childParentData.nextSibling;
      }
    }

    final AbstractNode? targetParent = renderObject.parent;
    if (targetParent is RenderObject) targetParent.markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
