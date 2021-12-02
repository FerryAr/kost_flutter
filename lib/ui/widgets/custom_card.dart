import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final Color bgColor;
  final BorderRadius? borderRadius;
  final bool isShadow;
  final Color shadowColor;
  final double shadowOpacity;
  final double elevationX;
  final double elevationY;
  final double shadowBlur;
  final Widget? child;

  const CustomCard({
    Key? key,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.height,
    this.width,
    this.bgColor = Colors.transparent,
    this.borderRadius,
    required this.isShadow,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 1,
    this.elevationX = 0,
    this.elevationY = 1,
    this.shadowBlur = 6,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: shadowColor.withOpacity(shadowOpacity),
                  offset: Offset(elevationX, elevationY),
                  blurRadius: shadowBlur,
                ),
              ]
            : null,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child ?? Container(),
          ),
        ),
      ),
    );
  }
}
