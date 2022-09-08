import 'package:flutter/widgets.dart';
import 'package:globe_flutter_android/core/logic/core.dart';
import 'dart:math' as math;

class SSRect extends SSShapeBuilder {
  const SSRect({
    Key? key,
    required this.width,
    required this.height,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
  }) : super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: true,
          fill: fill,
          front: front,
          sortPoint: SSVector.zero,
        );

  final double width;
  final double height;

  @override
  PathBuilder buildPath() {
    return RectPathBuilder(width, height);
  }
}

class RectPathBuilder extends PathBuilder {
  final double width;
  final double height;

  RectPathBuilder(this.width, this.height);

  @override
  List<SSPathCommand> buildPath() {
    final x = width / 2;
    final y = height / 2;
    return [
      SSMove.vector(SSVector.only(x: -x, y: -y)),
      SSLine.vector(SSVector.only(x: x, y: -y)),
      SSLine.vector(SSVector.only(x: x, y: y)),
      SSLine.vector(SSVector.only(x: -x, y: y))
    ];
  }

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return oldPathBuilder is! RectPathBuilder ||
        oldPathBuilder.height != height ||
        oldPathBuilder.width != width;
  }
}

class SSRoundedRect extends SSShapeBuilder {
  final double width;
  final double height;
  final double borderRadius;

  const SSRoundedRect({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
  }) : super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: true,
          fill: fill,
          front: front,
          sortPoint: SSVector.zero,
        );

  @override
  PathBuilder buildPath() {
    return RoundedRectPathBuilder(width, height, borderRadius);
  }
}

class RoundedRectPathBuilder extends PathBuilder {
  final double width;
  final double height;
  final double borderRadius;

  RoundedRectPathBuilder(this.width, this.height, this.borderRadius);

  @override
  List<SSPathCommand> buildPath() {
    var xA = width / 2;
    var yA = height / 2;
    var shortSide = math.min(xA, yA);
    var cornerRadius = math.min(borderRadius, shortSide);
    var xB = xA - cornerRadius;
    var yB = yA - cornerRadius;
    var path = [
      SSMove.vector(SSVector.only(x: xB, y: -yA)),
      SSArc.list(
        [
          SSVector.only(x: xA, y: -yA),
          SSVector.only(x: xA, y: -yB),
        ],
        null,
      ),
    ];

    if (yB != 0) {
      path.add(SSLine.vector(SSVector.only(x: xA, y: yB)));
    }
    path.add(SSArc.list(
      [
        SSVector.only(x: xA, y: yA),
        SSVector.only(x: xB, y: yA),
      ],
      null,
    ));

    if (xB != 0) {
      path.add(SSLine.vector(SSVector.only(x: -xB, y: yA)));
    }
    path.add(SSArc.list(
      [
        SSVector.only(x: -xA, y: yA),
        SSVector.only(x: -xA, y: yB),
      ],
      null,
    ));

    if (yB != 0) {
      path.add(SSLine.vector(SSVector.only(x: -xA, y: -yB)));
    }
    path.add(SSArc.list([
      SSVector.only(x: -xA, y: -yA),
      SSVector.only(x: -xB, y: -yA),
    ]));

    if (xB != 0) {
      path.add(SSLine.vector(SSVector.only(x: xB, y: -yA)));
    }

    return path;
  }

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return oldPathBuilder is! RoundedRectPathBuilder ||
        oldPathBuilder.height != height ||
        oldPathBuilder.width != width ||
        oldPathBuilder.borderRadius != borderRadius;
  }
}

class SSCircle extends SSShapeBuilder {
  final double diameter;

  final int quarters;

  const SSCircle({
    Key? key,
    required this.diameter,
    this.quarters = 4,
    required Color color,
    bool closed = false,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
  })  : assert(quarters >= 0 && quarters <= 4),
        super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: closed,
          fill: fill,
          front: front,
          sortPoint: SSVector.zero,
        );

  @override
  PathBuilder buildPath() {
    return EllipsePathBuilder(
      height: diameter,
      width: diameter,
      quarters: quarters,
    );
  }
}

class SSEllipse extends SSShapeBuilder {
  final double width;
  final double height;

  final int quarters;

  const SSEllipse({
    Key? key,
    required this.width,
    required this.height,
    this.quarters = 4,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
  })  : assert(quarters >= 0 && quarters <= 4),
        super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: false,
          fill: fill,
          front: front,
          sortPoint: SSVector.zero,
        );

  @override
  PathBuilder buildPath() {
    return EllipsePathBuilder(
      height: height,
      width: width,
      quarters: quarters,
    );
  }
}

class EllipsePathBuilder extends PathBuilder {
  final double width;
  final double height;

  final int quarters;

  EllipsePathBuilder({
    required this.width,
    required this.height,
    required this.quarters,
  });

  @override
  List<SSPathCommand> buildPath() {
    var x = width / 2;
    var y = height / 2;

    var path = [
      SSLine.vector(SSVector.only(x: 0, y: -y)),
      SSArc(
        corner: SSVector.only(x: x, y: -y),
        end: SSVector.only(x: x, y: 0),
      ),
    ];

    if (quarters > 1) {
      path.add(
        SSArc(
          corner: SSVector.only(x: x, y: y),
          end: SSVector.only(x: 0, y: y),
        ),
      );
    }
    if (quarters > 2) {
      path.add(
        SSArc(
          corner: SSVector.only(x: -x, y: y),
          end: SSVector.only(x: -x, y: 0),
        ),
      );
    }
    if (quarters > 3) {
      path.add(
        SSArc(
          corner: SSVector.only(x: -x, y: -y),
          end: SSVector.only(x: 0, y: -y),
        ),
      );
    }

    return path;
  }

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return oldPathBuilder is! EllipsePathBuilder ||
        oldPathBuilder.height != height ||
        oldPathBuilder.width != width ||
        oldPathBuilder.quarters != quarters;
  }
}

class SSPolygon extends SSShapeBuilder {
  final int sides;
  final double radius;

  const SSPolygon({
    Key? key,
    required this.sides,
    required this.radius,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    SSVector front = const SSVector.only(z: 1),
  })  : assert(sides > 2),
        assert(radius > 0),
        super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: true,
          fill: fill,
          front: front,
          sortPoint: SSVector.zero,
        );

  @override
  PathBuilder buildPath() {
    return PolygonPathBuilder(sides: sides, radius: radius);
  }
}

class PolygonPathBuilder extends PathBuilder {
  final int sides;
  final double radius;

  PolygonPathBuilder({
    required this.sides,
    required this.radius,
  });

  @override
  List<SSPathCommand> buildPath() {
    return List.generate(sides, (index) {
      final double theta = index / sides * tau - tau / 4;
      final double x = math.cos(theta) * radius;
      final double y = math.sin(theta) * radius;
      return SSLine.vector(SSVector.only(x: x, y: y));
    });
  }

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return oldPathBuilder is! PolygonPathBuilder ||
        oldPathBuilder.sides != sides ||
        oldPathBuilder.radius != radius;
  }
}
