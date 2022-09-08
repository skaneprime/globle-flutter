import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core.dart';

abstract class SSShapeBuilder extends SingleChildRenderObjectWidget
    with SSWidget {
  final Color color;
  final double stroke;
  final bool closed;
  final bool fill;
  final SSVector front;
  final Color? backfaceColor;
  final bool visible;
  final SSVector? sortPoint;

  const SSShapeBuilder({
    Key? key,
    required this.color,
    this.front = const SSVector.only(z: 1),
    this.backfaceColor,
    this.stroke = 1,
    this.closed = true,
    this.fill = false,
    this.visible = true,
    this.sortPoint,
  })  : assert(stroke >= 0),
        super(key: key);

  PathBuilder buildPath();

  @override
  RenderSSShape createRenderObject(BuildContext context) {
    return RenderSSShape(
        color: color,
        pathBuilder: buildPath(),
        stroke: stroke,
        close: closed,
        fill: fill,
        visible: visible,
        backfaceColor: backfaceColor,
        front: front,
        sortPoint: sortPoint);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSSShape renderObject) {
    renderObject.color = color;
    renderObject.pathBuilder = buildPath();
    renderObject.stroke = stroke;
    renderObject.close = closed;
    renderObject.fill = fill;
    renderObject.backfaceColor = backfaceColor;
    renderObject.front = front;
    renderObject.visible = visible;
    renderObject.sortPoint = sortPoint;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('stroke', stroke));
    properties.add(
      ColorProperty('backfaceColor', backfaceColor),
    );
  }

  @override
  SSSingleChildRenderObjectElement createElement() =>
      SSSingleChildRenderObjectElement(this);
}

class SSShape extends SSShapeBuilder {
  final PathBuilder path;

  SSShape({
    Key? key,
    List<SSPathCommand>? path,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
    bool visible = true,
    bool closed = true,
  })  : path = SimplePathBuilder(path ?? const []),
        assert(stroke >= 0),
        super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: closed,
          fill: fill,
          front: front,
          visible: visible,
        );

  @override
  PathBuilder buildPath() => path;
}
