import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

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
  late Scene _scene;

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
            _earth!.rotation.x = _controller.value * -360;
            _earth!.updateTransform();
            _scene.update();
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
    _scene = scene;
    if (widget.interative) {
      _scene.camera.position.z = 20;
    } else {
      _scene.camera.position.z = 13;
    }

    _earth = Object(
      name: 'earth',
      scale: Vector3(12.0, 12.0, 12.0),
      backfaceCulling: false,
      fileName: 'assets/earth/earth.obj',
    );

    _scene.world.add(_earth!);
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
