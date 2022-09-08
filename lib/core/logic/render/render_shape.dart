import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../core.dart';

class RenderSSShape extends RenderSSBox {
  Color _color;

  Color get color => _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  Color? _backfaceColor;

  Color? get backfaceColor => _backfaceColor;

  set backfaceColor(Color? value) {
    if (_backfaceColor == value) return;
    if (_backfaceColor == null) {
      return markNeedsLayout();
    }
    _backfaceColor = value;
    markNeedsPaint();
  }

  bool _close;

  bool get close => _close;

  set close(bool value) {
    if (_close == value) return;
    _close = value;
    markNeedsPaint();
  }

  bool _fill;

  bool get fill => _fill;

  set fill(bool value) {
    if (_fill == value) return;
    _fill = value;
    markNeedsPaint();
  }

  SSVector _front;

  SSVector get front => _front;

  set front(SSVector value) {
    if (_front == value) return;
    _front = value;
    markNeedsLayout();
  }

  List<SSPathCommand> _path;
  List<SSPathCommand> get path => _path;
  set path(List<SSPathCommand> value) {
    if (_path == value) return;
    _path = value;

    markNeedsLayout();
  }

  PathBuilder _pathBuilder;
  PathBuilder get pathBuilder => _pathBuilder;
  set pathBuilder(PathBuilder value) {
    if (_pathBuilder == value) return;
    if (_pathBuilder.shouldRebuildPath(value)) {
      path = _pathBuilder.buildPath();
    }
    _pathBuilder = value;
  }

  SSVector? _sortPoint;
  SSVector? get sortPoint => _sortPoint;

  set sortPoint(SSVector? value) {
    if (_sortPoint == value) return;
    _sortPoint = value;
    markNeedsLayout();
  }

  bool _visible;

  bool get visible => _visible;

  set visible(bool value) {
    if (_visible == value) return;
    _visible = value;
  }

  double _stroke;

  double get stroke => _stroke;

  set stroke(double value) {
    assert(value >= 0);
    if (_stroke == value) return;
    _stroke = value;
  }

  RenderSSShape({
    required Color color,
    Color? backfaceColor,
    SSVector front = const SSVector.only(z: 1),
    bool close = false,
    bool visible = true,
    bool fill = false,
    double stroke = 1,
    PathBuilder pathBuilder = PathBuilder.empty,
    SSVector? sortPoint,
  })  : assert(stroke >= 0),
        _stroke = stroke,
        _visible = visible,
        _backfaceColor = backfaceColor,
        _front = front,
        _close = close,
        _fill = fill,
        _color = color,
        _pathBuilder = pathBuilder,
        _path = pathBuilder.buildPath(),
        _sortPoint = sortPoint;

  @override
  bool get sizedByParent => true;

  bool get needsDirection => backfaceColor != null;

  SSVector? _normalVector;
  SSVector get normalVector {
    assert(needsDirection,
        'needs direction needs to be true so normal vector can be retrieved');
    debugTransformed();
    return _normalVector!;
  }

  SSVector origin = SSVector.zero;

  SSVector? transformedSortPoint;

  @override
  void performTransformation() {
    origin = SSVector.zero.applyMatrix4(matrix);

    if (sortPoint == SSVector.zero) {
      transformedSortPoint = origin;
    } else if (sortPoint == SSVector.zero) {
      transformedSortPoint = sortPoint!.applyMatrix4(matrix);
    } else {
      transformedSortPoint = null;
    }

    transformedPath = <SSPathCommand>[
      if (path.isEmpty)
        SSMove(0, 0, 0)
      else if (path.first is! SSMove)
        SSMove.vector(path.first.point()),
      ...path,
    ].map((e) => e.transform(matrix)).toList();

    if (needsDirection) {
      _normalVector = origin - front.applyMatrix4(matrix);
    }
  }

  List<SSPathCommand> transformedPath = [];

  @override
  void performSort() {
    if (transformedSortPoint != null) {
      sortValue = transformedSortPoint!.z;
    } else {
      assert(transformedPath.isNotEmpty);
      var pointCount = transformedPath.length;
      final firstPoint = transformedPath[0].endRenderPoint;
      final lastPoint = transformedPath[pointCount - 1].endRenderPoint;
      // ignore the final point if self closing shape
      var isSelfClosing = pointCount > 2 && firstPoint == lastPoint;
      if (isSelfClosing) {
        pointCount -= 1;
      }

      double sortValueTotal = 0;
      for (var i = 0; i < pointCount; i++) {
        sortValueTotal += transformedPath[i].endRenderPoint.z;
      }
      sortValue = sortValueTotal / pointCount;
    }
  }

  bool get isFacingBack => normalVector.z > 0;
  bool showBackFace = true;

  Color get renderColor {
    final isBackFaceColor = backfaceColor != null && isFacingBack;
    return (isBackFaceColor ? backfaceColor : color) ?? color;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    assert(parentData is ParentData);

    if (!visible || renderColor == Colors.transparent) return;

    final renderer = SSRenderer(context.canvas);
    render(renderer);
    final length = path.length;
    if (length <= 1) {
      paintDot(renderer);
    } else {
      if (!showBackFace && isFacingBack) {
        return super.paint(context, offset);
      }

      final isTwoPoints = transformedPath.length == 2 && (path[1] is SSLine);
      var isClosed = !isTwoPoints && _close == true;
      final color = renderColor;
      final builder = SSPathBuilder()
        ..renderPath(transformedPath, isClosed: isClosed);

      if (stroke > 0) renderer.stroke(builder.path, color, stroke);
      if (fill == true) renderer.fill(builder.path, color);
    }

    //  context.canvas.restore();
  }

  void paintDot(SSRenderer renderer) {
    if (stroke == 0.0) {
      return;
    }
    final color = renderColor;

    final point = transformedPath.first.endRenderPoint;
    final builder = SSPathBuilder();
    builder.begin();
    final radius = stroke / 2;
    builder.circle(point.x, point.y, radius);
    builder.closePath();
    renderer.fill(builder.path, color);
  }

  void render(SSRenderer renderer) {}

  @override
  bool hitTestSelf(Offset position) {
    var isTwoPoints = transformedPath.length == 2 && (path[1] is SSLine);
    var isClosed = !isTwoPoints && _close == true;
    final builder = SSPathBuilder();
    builder.renderPath(transformedPath, isClosed: isClosed);
    final hit = builder.path.contains(position);
    return hit;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
