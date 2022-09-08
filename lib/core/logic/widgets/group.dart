import 'package:flutter/material.dart';
import '../core.dart';

class SSGroup extends SSMultiChildWidget {
  SSGroup({
    super.key,
    required List<Widget> children,
    this.sortMode = SortMode.inherit,
    this.sortPoint,
  })  : assert(sortPoint == null || sortMode == SortMode.update,
            'sortPoint can only be used with SortMode.update'),
        super(children: children);

  final SortMode sortMode;
  final SSVector? sortPoint;

  @override
  RenderMultiChildBoxSS createRenderObject(BuildContext context) {
    return RenderMultiChildBoxSS(sortMode: sortMode, sortPoint: sortPoint);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMultiChildBoxSS renderObject) {
    renderObject.sortMode = sortMode;
    renderObject.sortPoint = sortPoint;
  }
}
