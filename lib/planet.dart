import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'globals.dart' as globals;

class Planet extends StatefulWidget {
  const Planet(
      {Key? key,
      required this.interative,
      required this.width,
      required this.height})
      : super(key: key);
  final bool interative;
  final double width;
  final double height;
  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with SingleTickerProviderStateMixin {
  Object? _earth;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (!widget.interative) {
          if (_earth != null) {
            _earth!.rotation.y = _controller.value * -360;
            _earth!.updateTransform();
            globals.scene.update();
          }
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _onSceneCreated(Scene scene) {
    globals.scene = scene;
    globals.scene.world.add(globals.earth);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height, // MediaQuery.of(context).size.height / 5
      width: widget.width, // MediaQuery.of(context).size.width,
      child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 0),
          curve: Curves.easeIn,
          tween: Tween(begin: 0, end: 1),
          builder: (context, animation, child) {
            return Opacity(
              opacity: animation,
              child: Cube(
                onObjectCreated: (object) {},
                onSceneCreated: _onSceneCreated,
                interactive: widget.interative,
              ),
            );
          }),
    );
  }
}
