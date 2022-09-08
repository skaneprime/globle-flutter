import 'package:flutter/widgets.dart';
import 'package:globe_flutter_android/core/logic/render/render_box_adapter.dart';
import 'package:globe_flutter_android/core/logic/core.dart';

class SSToBoxAdapter extends SingleChildRenderObjectWidget with SSWidget {
  final double height;

  final double width;

  const SSToBoxAdapter({
    Key? key,
    required this.height,
    required this.width,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderToBoxAdapter createRenderObject(BuildContext context) =>
      RenderToBoxAdapter(height: height, width: width);

  @override
  void updateRenderObject(
      BuildContext context, RenderToBoxAdapter renderObject) {
    renderObject.height = height;
    renderObject.width = width;
    super.updateRenderObject(context, renderObject);
  }

  @override
  SSSingleChildRenderObjectElement createElement() =>
      SSSingleChildRenderObjectElement(this);
}
