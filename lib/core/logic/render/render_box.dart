import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import '../core.dart';

abstract class RenderSSBox extends RenderBox {
  bool _debugSortedValue = false;
  bool _debugTransformedValue = false;

  double sortValue = 0;

  @override
  @mustCallSuper
  void performLayout() {
    _debugTransformedValue = false;
    _buildMatrix();
    performTransformation();
    _debugTransformedValue = true;
    sort();
  }

  Matrix4? _matrix;
  Matrix4 get matrix {
    assert(_matrix != null, 'Matrix accessed before performing layout');
    return _matrix!;
  }

  _buildMatrix() {
    final anchorParentData = parentData;

    _matrix = Matrix4.identity();
    if (anchorParentData is ParentSSData) {
      for (var transform in anchorParentData.transforms) {
        final matrix4 = Matrix4.translationValues(transform.translate.x,
            transform.translate.y, transform.translate.z);

        matrix4.rotateX(transform.rotate.x);
        matrix4.rotateY(-transform.rotate.y);
        matrix4.rotateZ(transform.rotate.z);

        matrix4.scale(transform.scale.x, transform.scale.y, transform.scale.z);
        matrix.multiply(matrix4);
      }
    }
  }

  @override
  bool get sizedByParent => true;

  void performTransformation();

  void performSort();

  int compareSort(RenderSSBox renderBox) {
    return sortValue.compareTo(renderBox.sortValue);
  }

  @mustCallSuper
  void sort() {
    _debugSortedValue = true;
    performSort();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(_debugSortedValue, 'requires sorted value');
    debugTransformed();
    super.paint(context, offset);
  }

  void debugTransformed() {
    assert(_debugTransformedValue, 'requires transformation to be performed');
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void performResize() {
    size = constraints.biggest;
    assert(size.isFinite);
  }
}

enum SortMode {
  inherit,
  stack,
  update,
}

class RenderMultiChildBoxSS extends RenderSSBox
    with
        ContainerRenderObjectMixin<RenderSSBox, ParentSSData>,
        RenderBoxContainerDefaultsMixin<RenderSSBox, ParentSSData> {
  RenderMultiChildBoxSS({
    List<RenderSSBox>? children,
    SortMode? sortMode = SortMode.inherit,
    SSVector? sortPoint,
  })  : assert(sortMode != null),
        sortMode = sortMode,
        _sortPoint = sortPoint {
    addAll(children);
  }

  @override
  void setupParentData(RenderSSBox child) {
    if (parentData is ParentSSData) {
      child.parentData = (parentData as ParentSSData).clone();
      return;
    }
    if (child.parentData is! ParentSSData) {
      child.parentData = ParentSSData();
    }
  }

  @override
  bool get sizedByParent => true;

  @override
  void performTransformation() {
    final BoxConstraints constraints = this.constraints;

    RenderSSBox? child = firstChild;

    while (child != null) {
      final ParentSSData childParentData = child.parentData as ParentSSData;
      if (child is RenderMultiChildBoxSS &&
          child.sortMode == SortMode.inherit) {
        child.layout(constraints, parentUsesSize: true);
      } else {
        child.layout(constraints, parentUsesSize: true);
      }
      child = childParentData.nextSibling;
    }
  }

  SSVector? get sortPoint => _sortPoint;
  SSVector? _sortPoint;
  set sortPoint(SSVector? value) {
    if (value == sortPoint) return;
    _sortPoint = value;
    markNeedsLayout();
  }

  List<RenderSSBox>? sortedChildren;

  @override
  void performSort() {
    final children = _getFlatChildren();
    if (sortMode == SortMode.stack || sortMode == SortMode.update) {
      if (sortPoint != null) {
        sortValue = _sortPoint!.applyMatrix4(matrix).z;
      } else {
        sortValue = children.fold<double>(0, (previousValue, element) {
              return (previousValue + element.sortValue);
            }) /
            children.length;
      }
    }
    if (sortMode == SortMode.update) {
      children.sort((a, b) => a.compareSort(b));
    }
    sortedChildren = children;
  }

  SortMode? sortMode;

  List<RenderSSBox> _getFlatChildren() {
    List<RenderSSBox> children = [];

    RenderSSBox? child = firstChild;

    while (child != null) {
      final ParentSSData childParentData = child.parentData as ParentSSData;

      if (child is RenderMultiChildBoxSS &&
          child.sortMode == SortMode.inherit) {
        children.addAll(child._getFlatChildren());
      } else {
        children.add(child);
      }
      child = childParentData.nextSibling;
    }
    return children;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(sortMode != null);
    if (sortMode == SortMode.inherit) return;

    for (final child in sortedChildren!) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool defaultHitTestChildren(BoxHitTestResult result,
      {required Offset position}) {
    if (sortMode == SortMode.inherit) return false;
    List<RenderSSBox> children = sortedChildren!;

    for (final child in children.reversed) {
      final bool isHit = child.hitTest(result, position: position);

      if (isHit) return true;
    }
    return false;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class ParentSSData extends ContainerBoxParentData<RenderSSBox> {
  List<SSTransform> transforms;

  ParentSSData({
    List<SSTransform>? transforms,
  }) : transforms = transforms ?? [];

  ParentSSData clone() {
    return ParentSSData(
      transforms: List<SSTransform>.from(transforms),
    );
  }
}
