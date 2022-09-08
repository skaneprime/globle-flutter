import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/logic/core.dart';
import 'package:globe_flutter_android/core/logic/widgets/figures/rect.dart';
import 'package:globe_flutter_android/core/logic/widgets/group.dart';

class SSBox extends StatelessWidget {
  final double width;
  final double height;
  final double depth;

  final double stroke;
  final bool fill;

  final Color color;
  final bool visible;

  final Color? frontColor;
  final Color? rearColor;
  final Color? leftColor;
  final Color? rightColor;
  final Color? topColor;
  final Color? bottomColor;

  const SSBox({
    super.key,
    required this.width,
    required this.height,
    required this.depth,
    this.stroke = 1,
    this.fill = true,
    required this.color,
    this.visible = true,
    this.frontColor,
    this.rearColor,
    this.leftColor,
    this.rightColor,
    this.topColor,
    this.bottomColor,
  });

  Widget get frontFace => SSPositioned(
        translate: SSVector.only(z: depth / 2),
        child: SSRect(
          color: frontColor ?? color,
          fill: fill,
          stroke: stroke,
          width: width,
          height: height,
        ),
      );

  Widget get rearFace => SSPositioned(
        translate: SSVector.only(z: -depth / 2),
        rotate: const SSVector.only(y: tau / 2),
        child: SSRect(
          width: width,
          height: height,
          color: rearColor ?? color,
          fill: fill,
          stroke: stroke,
        ),
      );

  Widget get leftFace => SSPositioned(
        translate: SSVector.only(x: -width / 2),
        rotate: const SSVector.only(y: -tau / 4),
        child: SSRect(
          width: depth,
          height: height,
          stroke: stroke,
          color: leftColor ?? color,
          fill: fill,
        ),
      );

  Widget get rightFace => SSPositioned(
        translate: SSVector.only(x: width / 2),
        rotate: const SSVector.only(y: tau / 4),
        child: SSRect(
          width: depth,
          color: rightColor ?? color,
          height: height,
          stroke: stroke,
          fill: fill,
        ),
      );

  Widget get topFace => SSPositioned(
        translate: SSVector.only(y: -height / 2),
        rotate: const SSVector.only(x: -tau / 4),
        child: SSRect(
          width: width,
          color: topColor ?? color,
          height: depth,
          stroke: stroke,
          fill: fill,
        ),
      );

  Widget get bottomFace => SSPositioned(
        translate: SSVector.only(y: height / 2),
        rotate: const SSVector.only(x: tau / 4),
        child: SSRect(
          width: width,
          color: bottomColor ?? color,
          stroke: stroke,
          fill: fill,
          height: depth,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SSGroup(
      children: [
        frontFace,
        rearFace,
        leftFace,
        rightFace,
        topFace,
        bottomFace,
      ],
    );
  }
}

class SSBoxToBoxAdapter extends StatelessWidget {
  final double width;
  final double height;
  final double depth;

  final double stroke;
  final bool fill;

  final Color color;
  final bool visible;

  final Widget? front;
  final Widget? rear;
  final Widget? left;
  final Widget? right;
  final Widget? top;
  final Widget? bottom;

  const SSBoxToBoxAdapter({
    super.key,
    required this.width,
    required this.height,
    required this.depth,
    this.stroke = 1,
    this.fill = true,
    required this.color,
    this.visible = true,
    this.front,
    this.rear,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  Widget get frontFace => SSPositioned(
        translate: SSVector.only(z: depth / 2),
        child: front != null
            ? SSToBoxAdapter(
                height: height,
                width: width,
                child: front,
              )
            : SSRect(
                color: color,
                fill: fill,
                stroke: stroke,
                width: width,
                height: height,
              ),
      );

  Widget get rearFace => SSPositioned(
        translate: SSVector.only(z: -depth / 2),
        rotate: const SSVector.only(y: tau / 2),
        child: rear != null
            ? SSToBoxAdapter(
                width: width,
                height: height,
                child: rear,
              )
            : SSRect(
                width: width,
                height: height,
                color: color,
                fill: fill,
                stroke: stroke,
              ),
      );

  Widget get leftFace => SSPositioned(
        translate: SSVector.only(x: -width / 2),
        rotate: const SSVector.only(y: -tau / 4),
        child: left != null
            ? SSToBoxAdapter(
                width: depth,
                height: height,
                child: left,
              )
            : SSRect(
                width: depth,
                height: height,
                stroke: stroke,
                color: color,
                fill: fill,
              ),
      );

  Widget get rightFace => SSPositioned(
        translate: SSVector.only(x: width / 2),
        rotate: const SSVector.only(y: tau / 4),
        child: right != null
            ? SSToBoxAdapter(
                width: depth,
                height: height,
                child: right,
              )
            : SSRect(
                width: depth,
                height: height,
                color: color,
                stroke: stroke,
                fill: fill,
              ),
      );

  Widget get topFace => SSPositioned(
        translate: SSVector.only(y: -height / 2),
        rotate: const SSVector.only(x: -tau / 4),
        child: top != null
            ? SSToBoxAdapter(
                width: width,
                height: depth,
                child: top,
              )
            : SSRect(
                width: width,
                height: depth,
                color: color,
                stroke: stroke,
                fill: fill,
              ),
      );

  Widget get bottomFace => SSPositioned(
        translate: SSVector.only(y: height / 2),
        rotate: const SSVector.only(x: tau / 4),
        child: bottom != null
            ? SSToBoxAdapter(
                width: width,
                height: depth,
                child: bottom,
              )
            : SSRect(
                width: width,
                height: depth,
                color: color,
                stroke: stroke,
                fill: fill,
              ),
      );

  @override
  Widget build(BuildContext context) {
    return SSGroup(
      children: [
        frontFace,
        rearFace,
        leftFace,
        rightFace,
        topFace,
        bottomFace,
      ],
    );
  }
}
