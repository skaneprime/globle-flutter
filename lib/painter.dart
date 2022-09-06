import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Path path;
  final Color color;
  final bool showPath;
  final double scale;
  MyPainter(this.path, this.color, {this.showPath = true, this.scale = 1});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);

    var paint = Paint()
      ..color = color
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
    if (showPath) {
      var border = Paint()
        ..color = Colors.black
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, border);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Country extends StatelessWidget {
  final String name;
  final Path path;
  final Color color;
  final bool showPath;
  final double scale;

  const Country(this.name, this.path, this.color,
      {super.key, this.showPath = true, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(path, color, scale: scale),
    );
  }
}

class World extends StatelessWidget {
  final List<Path> path;
  final Color color;
  final bool showPath;
  final double scale;

  const World(this.path, this.color,
      {super.key, this.showPath = true, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(path, color, scale: scale),
    );
  }
}

class Painter extends CustomPainter {
  final List<Path> path;
  final Color color;
  final bool showPath;
  final double scale;
  Painter(this.path, this.color, {this.showPath = true, this.scale = 1});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);
    for (int i = 0; path[i + 1] != null; i++) {
      var paint = Paint()
        ..color = color
        ..strokeWidth = 4.0;
      canvas.drawPath(path[i], paint);
      if (showPath) {
        var border = Paint()
          ..color = Colors.black
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;
        canvas.drawPath(path[i], border);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
