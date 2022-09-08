import 'package:flutter/rendering.dart';
import '../core.dart';

class RenderToBoxAdapter extends RenderSSBox
    with RenderObjectWithChildMixin<RenderBox> {
  double _width;

  double get width => _width;

  set width(double value) {
    if (_width == value) return;
    _width = value;
    markNeedsLayout();
  }

  double _height;

  double get height => _height;

  set height(double value) {
    if (_height == value) return;
    _height = value;
    markNeedsLayout();
  }

  RenderToBoxAdapter({
    required double width,
    required double height,
  })  : _width = width,
        _height = height;

  @override
  bool get isRepaintBoundary => true;

  List<SSPathCommand>? transformedPath;

  @override
  void performLayout() {
    child?.layout(
      BoxConstraints.expand(height: height, width: width),
      parentUsesSize: false,
    );
    super.performLayout();
  }

  SSVector origin = SSVector.zero;
  @override
  void performTransformation() {
    origin = SSVector.zero.applyMatrix4(matrix);
  }

  @override
  void performSort() {
    sortValue = origin.z;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (child != null) {
      final TransformLayer layer = TransformLayer();
      layer.transform = matrix.clone()..translate(-width / 2, -height / 2);
      context.pushLayer(
        layer,
        (context, _) {
          context.paintChild(child!, offset);
        },
        offset,
        childPaintBounds: context.estimatedBounds,
      );
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintTransform(
      transform: matrix,
      position: position,
      hitTest: (result, Offset position) {
        return child?.hitTest(
              result,
              position: position + Offset(width / 2, height / 2),
            ) ??
            false;
      },
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(matrix);
    transform.translate(-width / 2, -height / 2);
  }
}
