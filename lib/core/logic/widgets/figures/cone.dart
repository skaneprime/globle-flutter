import 'package:flutter/cupertino.dart';
import 'package:globe_flutter_android/core/logic/core.dart';
import 'dart:math' as math;

import 'package:globe_flutter_android/core/logic/widgets/figures/rect.dart';

class SSCone extends SSCircle {
  final double diameter;
  final double length;

  SSCone({
    required this.length,
    Key? key,
    required this.diameter,
    required Color color,
    bool closed = false,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = true,
    SSVector front = const SSVector.only(z: 1),
  })  : assert(diameter != null),
        super(
            key: key,
            color: color,
            backfaceColor: backfaceColor,
            stroke: stroke,
            closed: closed,
            fill: fill,
            front: front,
            diameter: diameter);

  @override
  RenderSSCone createRenderObject(BuildContext context) {
    return RenderSSCone(
        color: color,
        pathBuilder: buildPath(),
        stroke: stroke,
        close: closed,
        fill: fill,
        visible: visible,
        backfaceColor: backfaceColor,
        front: front,
        diameter: diameter,
        length: length);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSSCone renderObject) {
    renderObject.color = color;
    renderObject.pathBuilder = buildPath();
    renderObject.stroke = stroke;
    renderObject.close = closed;
    renderObject.fill = fill;
    renderObject.backfaceColor = backfaceColor;
    renderObject.front = front;
    renderObject.visible = visible;
    renderObject.length = length;
    renderObject.diameter = diameter;
  }
}

class RenderSSCone extends RenderSSShape {
  double _length;

  double get length => _length;

  set length(double value) {
    assert(value >= 0);
    if (_length == value) return;
    _length = value;
    markNeedsLayout();
  }

  double _diameter;

  double get diameter => _diameter;

  set diameter(double value) {
    assert(value >= 0);
    if (_diameter == value) return;
    _diameter = value;
    markNeedsLayout();
  }

  RenderSSCone({
    required double length,
    required double diameter,
    required Color color,
    Color? backfaceColor,
    SSVector front = const SSVector.only(z: 1),
    bool close = false,
    bool visible = true,
    bool fill = false,
    double stroke = 1,
    PathBuilder pathBuilder = PathBuilder.empty,
  })  : assert(length != null),
        assert(diameter != null),
        _length = length,
        _diameter = diameter,
        super(
          color: color,
          backfaceColor: backfaceColor,
          front: front,
          close: close,
          visible: visible,
          fill: fill,
          stroke: stroke,
          pathBuilder: pathBuilder,
        );

  SSVector tangentA = SSVector.zero;
  SSVector tangentB = SSVector.zero;

  SSVector? apex;

  @override
  void performTransformation() {
    super.performTransformation();
    final ParentSSData anchorParentData = parentData as ParentSSData;

    apex = SSVector.only(z: length);
    for (var matrix4 in anchorParentData.transforms.reversed) {
      apex = apex!.transform(matrix4.translate, matrix4.rotate, matrix4.scale);
    }
  }

  @override
  void performSort() {
    final renderCentroid = SSVector.lerp(origin, apex, 1 / 3);
    sortValue = renderCentroid.z;
  }

  SSVector renderApex = SSVector.zero;

  @override
  void render(SSRenderer renderer) {
    _renderConeSurface(renderer);
    super.render(renderer);
  }

  @override
  bool get needsDirection => true;

  void _renderConeSurface(SSRenderer renderer) {
    if (!visible) {
      return;
    }
    renderApex = apex! - origin;
    final scale = normalVector.magnitude();
    final apexDistance = renderApex.magnitude2d();
    final normalDistance = normalVector.magnitude2d();
    final eccenAngle = math.acos(normalDistance / scale);
    final eccen = math.sin(eccenAngle);
    final radius = diameter / 2 * scale;
    final isApexVisible = radius * eccen < apexDistance;
    if (!isApexVisible) {
      return;
    }

    final apexAngle = (math.atan2(normalVector.y, normalVector.x) + tau / 2);
    final projectLength = apexDistance / eccen;
    final projectAngle = math.acos(radius / projectLength);

    final xA = math.cos(projectAngle) * radius * eccen;
    final yA = math.sin(projectAngle) * radius;
    tangentA = tangentA.copyWith(x: xA, y: yA);
    tangentB = tangentA.multiply(SSVector.identity.copyWith(y: -1));

    tangentA = tangentA.rotateZ(apexAngle).addVector(origin);
    tangentB = tangentB.rotateZ(apexAngle).addVector(origin);

    final path = [
      SSMove.vector(tangentA),
      SSLine.vector(apex!),
      SSLine.vector(tangentB),
    ];
    final builder = SSPathBuilder()..renderPath(path);

    if (stroke > 0) renderer.stroke(builder.path, color, stroke);
    if (fill) renderer.fill(builder.path, color);
  }
}
