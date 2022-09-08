import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/logic/core.dart';

class SSRenderer {
  Paint paint = Paint()
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  final Canvas? canvas;

  SSRenderer(this.canvas);

  void setLineCap(StrokeCap value) {
    paint.strokeCap = value;
  }

  void stroke(Path path, Color color, double lineWidth) {
    paint.color = color;
    paint.strokeWidth = lineWidth;
    paint.style = PaintingStyle.stroke;
    canvas?.drawPath(path, paint);
  }

  void fill(Path path, Color color) {
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas?.drawPath(path, paint);
  }
}

class SSPathBuilder {
  Path path = Path();

  SSPathBuilder();

  void begin() {
    path.reset();
  }

  void move(SSVector point) {
    path.moveTo(point.x, point.y);
  }

  void line(SSVector point) {
    path.lineTo(point.x, point.y);
  }

  void bezier(SSVector cp0, SSVector cp1, SSVector end) {
    path.cubicTo(
      cp0.x,
      cp0.y,
      cp1.x,
      cp1.y,
      end.x,
      end.y,
    );
  }

  void arc(double x, double y, double radius, double start, double end) {
    final rect = Rect.fromLTRB(x - radius, y - radius, x + radius, y + radius);
    path.arcTo(rect, start, start - end, false);
  }

  void circle(double x, double y, double radius) {
    final rect = Rect.fromLTRB(x - radius, y - radius, x + radius, y + radius);

    path.addOval(rect);
  }

  void closePath() {
    path.close();
  }

  Path renderPath(List<SSPathCommand> pathCommands, {bool isClosed = false}) {
    begin();
    SSVector previousPoint = SSVector.zero;
    for (var it in pathCommands) {
      it.render(this, previousPoint);
      previousPoint = it.endRenderPoint;
    }

    if (isClosed) {
      closePath();
    }
    return path;
  }
}
