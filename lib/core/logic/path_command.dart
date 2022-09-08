import 'core.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

abstract class SSPathCommand {
  final SSVector endRenderPoint = SSVector.zero;

  const SSPathCommand();

  SSPathCommand transform(vector.Matrix4 transformation);

  void render(
    SSPathBuilder renderer,
    SSVector previousPoint,
  );

  SSVector point({index = 0});

  SSVector renderPoint({int index = 0});
}

class SSMove extends SSPathCommand {
  final SSVector _point;

  @override
  SSVector get endRenderPoint => _point;

  const SSMove.vector(this._point);

  SSMove(double x, double y, double z) : _point = SSVector(x, y, z);

  SSMove.only({double x = 0, double y = 0, double z = 0})
      : _point = SSVector(x, y, z);

  @override
  SSPathCommand transform(vector.Matrix4 transformation) {
    return SSMove.vector(_point.applyMatrix4(transformation));
  }

  @override
  void render(SSPathBuilder renderer, SSVector previousPoint) {
    renderer.move(_point);
  }

  @override
  SSVector point({index = 0}) {
    return _point;
  }

  @override
  SSVector renderPoint({index = 0}) {
    return _point;
  }
}

class SSLine extends SSPathCommand {
  late SSVector _point;

  late SSVector _renderPoint;

  @override
  SSVector get endRenderPoint => _renderPoint;

  SSLine.vector(this._point) {
    _renderPoint = _point.copy();
  }

  SSLine(double x, double y, double z) {
    _point = SSVector(x, y, z);
    _renderPoint = SSVector(x, y, z);
  }

  SSLine.only({double x = 0, double y = 0, double z = 0}) {
    _point = SSVector(x, y, z);
    _renderPoint = SSVector(x, y, z);
  }

  @override
  SSPathCommand transform(vector.Matrix4 transformation) {
    return SSLine.vector(_renderPoint.applyMatrix4(transformation));
  }

  @override
  void render(SSPathBuilder renderer, SSVector previousPoint) {
    renderer.line(_renderPoint);
  }

  @override
  SSVector point({index = 0}) {
    return _point;
  }

  @override
  SSVector renderPoint({index = 0}) {
    return _renderPoint;
  }
}

class SSBezier extends SSPathCommand {
  List<SSVector> points;

  late List<SSVector> renderPoints;

  @override
  SSVector get endRenderPoint => renderPoints.last;

  SSBezier(this.points) {
    renderPoints = points.map((e) => e.copy()).toList();
  }

  @override
  SSPathCommand transform(vector.Matrix4 transformation) {
    return SSBezier(renderPoints.map((point) {
      return point.applyMatrix4(transformation);
    }).toList());
  }

  @override
  void render(SSPathBuilder renderer, SSVector previousPoint) {
    renderer.bezier(renderPoints[0], renderPoints[1], renderPoints[2]);
  }

  @override
  SSVector point({index = 0}) {
    return points[index];
  }

  @override
  SSVector renderPoint({index = 0}) {
    return renderPoints[index];
  }
}

const double _arcHandleLength = 9 / 16;

class SSArc extends SSPathCommand {
  late List<SSVector> points;

  late List<SSVector> renderPoints;

  @override
  SSVector get endRenderPoint => renderPoints.last;

  SSArc.list(this.points, [SSVector? previous]) {
    renderPoints = points.map((e) => e.copy()).toList();
  }

  SSArc({required SSVector corner, required SSVector end}) {
    points = [corner, end];

    renderPoints = points.map((e) => e.copy()).toList();
  }

  List<SSVector> controlPoints = [SSVector.zero, SSVector.zero];

  void reset() {
    renderPoints = List.generate(renderPoints.length, (i) => points[i]);
  }

  @override
  SSPathCommand transform(vector.Matrix4 transformation) {
    return SSArc.list(renderPoints.map((point) {
      return point.applyMatrix4(transformation);
    }).toList());
  }

  @override
  void render(SSPathBuilder renderer, SSVector previousPoint) {
    var prev = previousPoint;
    var corner = renderPoints[0];
    var end = renderPoints[1];
    var a = SSVector.lerp(prev, corner, _arcHandleLength);
    var b = SSVector.lerp(end, corner, _arcHandleLength);
    renderer.bezier(a, b, end);
  }

  @override
  SSVector point({index = 0}) {
    return points[index];
  }

  @override
  SSVector renderPoint({index = 0}) {
    return renderPoints[index];
  }
}
