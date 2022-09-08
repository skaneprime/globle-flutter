import 'dart:math';

import 'package:flutter/widgets.dart';
import '../core.dart';

typedef DragWidgetBuilder = Widget Function(
    BuildContext context, SSDragController controller);

class ZDragDetector extends StatefulWidget {
  final DragWidgetBuilder builder;

  const ZDragDetector({Key? key, required this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZDragDetectorState();
}

class _ZDragDetectorState extends State<ZDragDetector> {
  late SSDragController controller;
  Offset dragStart = Offset.zero;
  Offset dragStartR = Offset.zero;

  @override
  void initState() {
    controller = SSDragController(SSVector.zero);
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (event) {
          dragStartR = Offset(
            controller.rotate.x,
            controller.rotate.y,
          );
          dragStart = Offset(event.localPosition.dx, event.localPosition.dy);
        },
        onPanUpdate: (event) {
          var moveX = event.localPosition.dx - dragStart.dx;
          var moveY = event.localPosition.dy - dragStart.dy;

          var displaySize = MediaQuery.of(context).size;
          var minSize = min(displaySize.width, displaySize.height);
          var moveRY = moveX / minSize * tau;
          var moveRX = moveY / minSize * tau;
          controller._rotate = SSVector.only(
            x: dragStartR.dx - moveRX,
            y: dragStartR.dy - moveRY,
          );
        },
        child: widget.builder(
          context,
          controller,
        ));
  }

  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }
}

class SSDragController extends ValueNotifier<SSVector> {
  SSDragController(value) : super(value);

  SSVector get rotate => value;

  set _rotate(SSVector rotate) {
    value = rotate;
  }
}
