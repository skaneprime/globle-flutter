import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:ui';

import 'dart:math' as math;

export 'widgets/positioned.dart';
export 'widgets/shape.dart';
export 'widgets/widget.dart';
export 'render/render_box.dart';
export 'render/render_shape.dart';
export 'path_command.dart';
export 'renderer.dart';
export 'path_builder.dart';

export 'widgets/box_adapter.dart';

const tau = math.pi * 2;

class SSVector {
  final double x;
  final double y;
  final double z;

  const SSVector(this.x, this.y, this.z);

  const SSVector.only({this.x = 0, this.y = 0, this.z = 0});

  const SSVector.all(double value)
      : x = value,
        y = value,
        z = value;
  static const SSVector zero = SSVector.all(0);
  static const SSVector identity = SSVector.all(1);

  @override
  bool operator ==(other) =>
      other is SSVector && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => Object.hashAll([x, y, z]);

  SSVector add({double x = 0, double y = 0, double z = 0}) {
    return SSVector(this.x + x, this.y + y, this.z + z);
  }

  SSVector subtract({double x = 0, double y = 0, double z = 0}) {
    return SSVector(this.x - x, this.y - y, this.z - z);
  }

  SSVector subtractVector(SSVector v) {
    return SSVector(x - v.x, y - v.y, z - v.z);
  }

  SSVector addVector(SSVector v) {
    return SSVector(x + v.x, y + v.y, z + v.z);
  }

  SSVector rotate(SSVector? rotation) {
    if (rotation == null) return this;

    return rotateZ(rotation.z).rotateY(rotation.y).rotateX(rotation.x);
  }

  SSVector rotateZ(double angle) {
    return _rotateProperty(angle, VectorAxis.x, VectorAxis.y);
  }

  SSVector rotateX(double angle) {
    return _rotateProperty(angle, VectorAxis.y, VectorAxis.z);
  }

  SSVector rotateY(double angle) {
    return _rotateProperty(angle, VectorAxis.x, VectorAxis.z);
  }

  SSVector _rotateProperty(double angle, VectorAxis propA, VectorAxis propB) {
    if (angle % tau == 0) {
      return this;
    }
    var cos = math.cos(angle);
    var sin = math.sin(angle);
    var a = toMap[propA]!;
    var b = toMap[propB]!;

    return replaceAxisInMap(
        {propA: a * cos - b * sin, propB: b * cos + a * sin});
  }

  SSVector replaceAxisInMap(Map<VectorAxis, double> axis) {
    double? x = axis[VectorAxis.x];
    double? y = axis[VectorAxis.y];
    double? z = axis[VectorAxis.z];

    return SSVector(x ?? this.x, y ?? this.y, z ?? this.z);
  }

  Map<VectorAxis, double> get toMap =>
      {VectorAxis.x: x, VectorAxis.y: y, VectorAxis.z: z};

  SSVector multiply(SSVector? scale) {
    if (scale == null) return this;
    final mx = scale.x;
    final my = scale.y;
    final mz = scale.z;
    return SSVector(x * mx, y * my, z * mz);
  }

  SSVector divide(SSVector? scale) {
    if (scale == null) return this;
    final mx = scale.x;
    final my = scale.y;
    final mz = scale.z;
    return SSVector(x / mx, y / my, z / mz);
  }

  SSVector multiplyScalar(num? scale) {
    if (scale == null) return this;
    final m = scale;
    return SSVector(x * m, y * m, z * m);
  }

  SSVector transform(SSVector translation, SSVector rotation, SSVector scale) {
    return multiply(scale).rotate(rotation).addVector(translation);
  }

  static SSVector lerp(SSVector? a, SSVector? b, double t) {
    final x = lerpDouble(a?.x, b?.x ?? 0.0, t);
    final y = lerpDouble(a?.y, b?.y ?? 0.0, t);
    final z = lerpDouble(a?.z, b?.z ?? 0.0, t);
    return SSVector(x!, y!, z!);
  }

  double magnitude() {
    var sum = x * x + y * y + z * z;
    return getMagnitudeSqrt(sum);
  }

  double getMagnitudeSqrt(double sum) {
    // PERF: check if sum ~= 1 and skip sqrt
    if ((sum - 1).abs() < 0.00000001) {
      return 1;
    }
    return math.sqrt(sum);
  }

  double magnitude2d() {
    var sum = x * x + y * y;
    return getMagnitudeSqrt(sum);
  }

  SSVector copy() {
    return SSVector(x, y, z);
  }

  SSVector copyWith({double? x, double? y, double? z}) {
    return SSVector(x ?? this.x, y ?? this.y, z ?? this.z);
  }

  SSVector operator +(SSVector v) => addVector(v);

  SSVector operator -(SSVector v) => subtractVector(v);

  SSVector operator *(SSVector v) => multiply(v);

  SSVector operator /(SSVector v) => multiply(v);

  /// Cross product.
  SSVector cross(SSVector other) {
    final double _x = x;
    final double _y = y;
    final double _z = z;
    final double ox = other.x;
    final double oy = other.y;
    final double oz = other.z;
    return SSVector.only(
      x: _y * oz - _z * oy,
      y: _z * ox - _x * oz,
      z: _x * oy - _y * ox,
    );
  }

  SSVector unit() {
    var total = magnitude();
    return SSVector(x / total, y / total, z / total);
  }

  @override
  String toString() {
    return 'V($x, $y, $z)';
  }

  vector.Vector3 asVector3() {
    return vector.Vector3(x, y, z);
  }

  SSVector applyMatrix4(vector.Matrix4 arg) {
    final argStorage = arg.storage;
    final v0 = x;
    final v1 = y;
    final v2 = z;
    return SSVector(
      argStorage[0] * v0 +
          argStorage[4] * v1 +
          argStorage[8] * v2 +
          argStorage[12],
      argStorage[1] * v0 +
          argStorage[5] * v1 +
          argStorage[9] * v2 +
          argStorage[13],
      argStorage[2] * v0 +
          argStorage[6] * v1 +
          argStorage[10] * v2 +
          argStorage[14],
    );
  }
}

extension SSVector3 on vector.Vector3 {
  SSVector asVector() {
    return SSVector(x, y, z);
  }
}

enum VectorAxis { x, y, z }
