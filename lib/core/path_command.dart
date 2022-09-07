import 'core.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

abstract class ZPathCommand {
  final ZVector endRenderPoint = ZVector.zero;

  const ZPathCommand();

  ZPathCommand transform(vector.Matrix4 transformation);

  void render(
    ZPathBuilder renderer,
    ZVector previousPoint,
  );

  ZVector point({index = 0});

  ZVector renderPoint({int index = 0});
}

class ZMove extends ZPathCommand {
  final ZVector _point;

  @override
  ZVector get endRenderPoint => _point;

  const ZMove.vector(this._point);

  ZMove(double x, double y, double z) : _point = ZVector(x, y, z);

  ZMove.only({double x = 0, double y = 0, double z = 0})
      : _point = ZVector(x, y, z);

  @override
  ZPathCommand transform(vector.Matrix4 transformation) {
    return ZMove.vector(_point.applyMatrix4(transformation));
  }

  @override
  void render(ZPathBuilder renderer, ZVector previousPoint) {
    renderer.move(_point);
  }

  @override
  ZVector point({index = 0}) {
    return _point;
  }

  @override
  ZVector renderPoint({index = 0}) {
    return _point;
  }
}

class ZLine extends ZPathCommand {
  late ZVector _point;

  late ZVector _renderPoint;

  @override
  ZVector get endRenderPoint => _renderPoint;

  ZLine.vector(this._point) {
    _renderPoint = _point.copy();
  }

  ZLine(double x, double y, double z) {
    _point = ZVector(x, y, z);
    _renderPoint = ZVector(x, y, z);
  }

  ZLine.only({double x = 0, double y = 0, double z = 0}) {
    _point = ZVector(x, y, z);
    _renderPoint = ZVector(x, y, z);
  }

  @override
  ZPathCommand transform(vector.Matrix4 transformation) {
    return ZLine.vector(_renderPoint.applyMatrix4(transformation));
  }

  @override
  void render(ZPathBuilder renderer, ZVector previousPoint) {
    renderer.line(_renderPoint);
  }

  @override
  ZVector point({index = 0}) {
    return _point;
  }

  @override
  ZVector renderPoint({index = 0}) {
    return _renderPoint;
  }
}

class ZBezier extends ZPathCommand {
  List<ZVector> points;

  late List<ZVector> renderPoints;

  @override
  ZVector get endRenderPoint => renderPoints.last;

  ZBezier(this.points) {
    renderPoints = points.map((e) => e.copy()).toList();
  }

  @override
  ZPathCommand transform(vector.Matrix4 transformation) {
    return ZBezier(renderPoints.map((point) {
      return point.applyMatrix4(transformation);
    }).toList());
  }

  @override
  void render(ZPathBuilder renderer, ZVector previousPoint) {
    renderer.bezier(renderPoints[0], renderPoints[1], renderPoints[2]);
  }

  @override
  ZVector point({index = 0}) {
    return points[index];
  }

  @override
  ZVector renderPoint({index = 0}) {
    return renderPoints[index];
  }
}

const double _arcHandleLength = 9 / 16;

class ZArc extends ZPathCommand {
  late List<ZVector> points;

  late List<ZVector> renderPoints;

  @override
  ZVector get endRenderPoint => renderPoints.last;

  ZArc.list(this.points, [ZVector? previous]) {
    renderPoints = points.map((e) => e.copy()).toList();
  }

  ZArc({required ZVector corner, required ZVector end}) {
    points = [corner, end];

    renderPoints = points.map((e) => e.copy()).toList();
  }

  List<ZVector> controlPoints = [ZVector.zero, ZVector.zero];

  void reset() {
    renderPoints = List.generate(renderPoints.length, (i) => points[i]);
  }

  @override
  ZPathCommand transform(vector.Matrix4 transformation) {
    return ZArc.list(renderPoints.map((point) {
      return point.applyMatrix4(transformation);
    }).toList());
  }

  @override
  void render(ZPathBuilder renderer, ZVector previousPoint) {
    var prev = previousPoint;
    var corner = renderPoints[0];
    var end = renderPoints[1];
    var a = ZVector.lerp(prev, corner, _arcHandleLength);
    var b = ZVector.lerp(end, corner, _arcHandleLength);
    renderer.bezier(a, b, end);
  }

  @override
  ZVector point({index = 0}) {
    return points[index];
  }

  @override
  ZVector renderPoint({index = 0}) {
    return renderPoints[index];
  }
}
