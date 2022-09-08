import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../core.dart';

abstract class SSUpdateParentDataWidget<T extends ParentData>
    extends ProxyWidget {
  const SSUpdateParentDataWidget({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  UpdateParentDataElement<T> createElement() =>
      UpdateParentDataElement<T>(this);

  bool debugIsValidRenderObject(RenderObject renderObject) {
    assert(T != dynamic);
    assert(T != ParentData);
    return renderObject.parentData is T;
  }

  Type get debugTypicalAncestorWidgetClass;

// TODO: Implement this
//  Iterable<DiagnosticsNode> _debugDescribeIncorrectParentDataType({
//    @required ParentData parentData,
//    RenderObjectWidget parentDataCreator,
//    DiagnosticsNode ownershipChain,
//  }) sync* {
//    assert(T != dynamic);
//    assert(T != ParentData);
//    assert(debugTypicalAncestorWidgetClass != null);
//
//    final String description = 'The ParentDataWidget $this wants to apply ParentData of type $T to a RenderObject';
//    if (parentData == null) {
//      yield ErrorDescription(
//          '$description, which has not been set up to receive any ParentData.'
//      );
//    } else {
//      yield ErrorDescription(
//          '$description, which has been set up to accept ParentData of incompatible type ${parentData.runtimeType}.'
//      );
//    }
//    yield ErrorHint(
//        'Usually, this means that the $runtimeType widget has the wrong ancestor RenderObjectWidget. '
//            'Typically, $runtimeType widgets are placed directly inside $debugTypicalAncestorWidgetClass widgets.'
//    );
//    if (parentDataCreator != null) {
//      yield ErrorHint(
//          'The offending $runtimeType is currently placed inside a ${parentDataCreator.runtimeType} widget.'
//      );
//    }
//    if (ownershipChain != null) {
//      yield ErrorDescription(
//          'The ownership chain for the RenderObject that received the incompatible parent data was:\n  $ownershipChain'
//      );
//    }
//  }

  @protected
  void updateParentData(RenderObject renderObject,
      covariant SSUpdateParentDataWidget<T> oldWidget, SSTransform transform);

  @protected
  void startParentData(RenderObject renderObject, SSTransform transform);

  @protected
  bool debugCanApplyOutOfTurn() => false;
}

class UpdateParentDataElement<T extends ParentData> extends ProxyElement {
  UpdateParentDataElement(SSUpdateParentDataWidget<T> widget) : super(widget);

  @override
  SSUpdateParentDataWidget<T> get widget =>
      super.widget as SSUpdateParentDataWidget<T>;

  SSTransform transform = SSTransform();

  void _updateParentData(SSUpdateParentDataWidget<T> widget,
      SSUpdateParentDataWidget<T> oldWidget) {
    void applyParentDataToChild(Element child) {
      if (child is RenderObjectElement) {
        widget.updateParentData(child.renderObject, oldWidget, transform);
      } else {
        child.visitChildren(applyParentDataToChild);
      }
    }

    visitChildren(applyParentDataToChild);
  }

  void startParentData(RenderObject renderObject) {
    widget.startParentData(renderObject, transform);
  }

  void applyWidgetOutOfTurn(SSUpdateParentDataWidget<T> newWidget) {
    assert(newWidget.debugCanApplyOutOfTurn());
    assert(newWidget.child == widget.child);
    _updateParentData(newWidget, widget);
  }

  @override
  void notifyClients(SSUpdateParentDataWidget<T> oldWidget) {
    _updateParentData(widget, oldWidget);
  }
}
