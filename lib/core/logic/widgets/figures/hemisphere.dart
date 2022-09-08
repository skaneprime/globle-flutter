import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/logic/core.dart';
import 'package:globe_flutter_android/core/logic/widgets/figures/rect.dart';
import 'dart:math' as math;

import '../group.dart';

class SSHemisphere extends StatelessWidget {
  final double diameter;
  final double stroke;
  final Color color;
  final bool visible;
  final Color? backfaceColor;

  const SSHemisphere({
    super.key,
    this.diameter = 1,
    this.stroke = 1,
    required this.color,
    this.visible = true,
    this.backfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return SSGroup(
      sortMode: SortMode.stack,
      children: [
        _SSCylinderMiddle(
          color: color,
          diameter: diameter,
          stroke: stroke,
        ),
        SSCircle(
          diameter: diameter,
          backfaceColor: backfaceColor,
          color: color,
          stroke: stroke,
          fill: true,
        ),
      ],
    );
  }
}

class _SSCylinderMiddle extends SSShapeBuilder {
  final double diameter;

  const _SSCylinderMiddle({
    required this.diameter,
    double stroke = 1,
    required Color color,
  }) : super(stroke: stroke, color: color);

  @override
  _RenderSSHemisphere createRenderObject(BuildContext context) {
    return _RenderSSHemisphere(
      pathBuilder: buildPath(),
      stroke: stroke,
      diameter: diameter,
      color: color,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSSHemisphere renderObject) {
    renderObject.diameter = diameter;
    renderObject.stroke = stroke;
    renderObject.pathBuilder = buildPath();
    renderObject.color = color;
  }

  @override
  PathBuilder buildPath() {
    return PathBuilder.empty;
  }
}

class _RenderSSHemisphere extends RenderSSShape {
  double _diameter;

  double get diameter => _diameter;

  set diameter(double value) {
    if (_diameter == value) return;
    _diameter = value;

    markNeedsLayout();
  }

  SSVector? apex;
  @override
  void performTransformation() {
    super.performTransformation();
    final ParentSSData anchorParentData = parentData as ParentSSData;

    // print('relayout ${anchorParentData.transforms.length}');
    apex = SSVector.only(z: diameter / 2);
    for (var matrix4 in anchorParentData.transforms.reversed) {
      apex = apex!.transform(matrix4.translate, matrix4.rotate, matrix4.scale);
    }
  }

  @override
  void performSort() {
    final renderCentroid = SSVector.lerp(origin, apex, 3 / 8);
    sortValue = renderCentroid.z;
  }

  _RenderSSHemisphere(
      {required PathBuilder pathBuilder,
      required double diameter,
      required double stroke,
      required Color color})
      : _diameter = diameter,
        super(
            pathBuilder: pathBuilder, stroke: stroke, color: color, fill: true);

  @override
  bool get needsDirection => true;

  @override
  void render(SSRenderer renderer) {
    final contourAngle = math.atan2(normalVector.y, normalVector.x);
    final demoRadius = diameter / 2 * normalVector.magnitude();
    final x = origin.x;
    final y = origin.y;

    final startAngle = contourAngle + tau / 4;
    final endAnchor = contourAngle - tau / 4;
    final builder = SSPathBuilder();
    builder.begin();
    builder.move(origin);
    builder.arc(x, y, demoRadius, startAngle, endAnchor);
    builder.closePath();
    if (stroke > 0) renderer.stroke(builder.path, color, stroke);
    if (fill) renderer.fill(builder.path, color);
  }
}
