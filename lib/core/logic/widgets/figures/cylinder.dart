import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/logic/core.dart';
import 'package:globe_flutter_android/core/logic/widgets/figures/rect.dart';
import 'package:globe_flutter_android/core/logic/widgets/group.dart';

class SSCylinder extends StatelessWidget {
  final double diameter;
  final double length;

  final double stroke;
  final bool fill;

  final Color color;
  final bool visible;

  final Color? backface;
  final Color? frontface;

  const SSCylinder({
    super.key,
    this.diameter = 1,
    this.length = 1,
    this.stroke = 1,
    this.fill = true,
    required this.color,
    this.visible = true,
    this.backface,
    this.frontface,
  });

  @override
  Widget build(BuildContext context) {
    final baseZ = length / 2;
    final baseColor = backface;
    final frontBase = SSPositioned(
      translate: SSVector.only(z: baseZ),
      rotate: const SSVector.only(y: (tau / 2)),
      child: SSCircle(
        diameter: diameter,
        color: color,
        stroke: stroke,
        fill: fill,
        backfaceColor: frontface ?? baseColor,
      ),
    );

    final backBase = SSPositioned(
      translate: SSVector.only(z: -baseZ),
      rotate: const SSVector.only(y: 0),
      child: SSCircle(
        diameter: diameter,
        color: color,
        stroke: stroke,
        fill: fill,
        backfaceColor: baseColor,
      ),
    );

    return SSGroup(
      children: [
        frontBase,
        backBase,
        _SSCylinderMiddle(
          color: color,
          diameter: diameter,
          stroke: stroke,
          path: [
            SSMove.vector(SSVector.only(z: baseZ)),
            SSLine.vector(
              SSVector.only(z: -baseZ),
            )
          ],
        )
      ],
    );
  }
}

class _SSCylinderMiddle extends SSShapeBuilder {
  final double diameter;

  final List<SSPathCommand> path;

  const _SSCylinderMiddle(
      {required this.diameter,
      required this.path,
      double stroke = 1,
      required Color color})
      : super(stroke: stroke, color: color);

  @override
  RenderSSCylinder createRenderObject(BuildContext context) {
    return RenderSSCylinder(
      pathBuilder: buildPath(),
      stroke: stroke,
      diameter: diameter,
      color: color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSSCylinder renderObject) {
    renderObject.diameter = diameter;
    renderObject.stroke = stroke;
    renderObject.pathBuilder = buildPath();
    renderObject.color = color;
  }

  @override
  PathBuilder buildPath() {
    return SimplePathBuilder(path);
  }
}

class RenderSSCylinder extends RenderSSShape {
  double _diameter;

  double get diameter => _diameter;

  set diameter(double value) {
    if (_diameter == value) return;
    _diameter = value;

    markNeedsLayout();
  }

  RenderSSCylinder({
    required PathBuilder pathBuilder,
    required double diameter,
    required double stroke,
    required Color color,
  })  : _diameter = diameter,
        super(pathBuilder: pathBuilder, stroke: stroke, color: color);

  @override
  bool get needsDirection => true;
  @override
  void render(SSRenderer renderer) {
    final builder = SSPathBuilder()..renderPath(transformedPath);
    var scale = normalVector.magnitude();
    var strokeWidth = diameter * scale + stroke;

    renderer.setLineCap(StrokeCap.butt);
    renderer.stroke(builder.path, color, strokeWidth);
    renderer.setLineCap(StrokeCap.round);
    super.render(renderer);
  }
}
