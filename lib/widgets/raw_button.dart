import 'package:flutter/material.dart';

class RawButton extends StatelessWidget {
  const RawButton({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.radius = 8,
    this.color,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.elevation = 0,
  });

  final Widget child;
  final Function onTap;
  final Function? onLongPress;
  final double radius;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          elevation: elevation,
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
          child: InkWell(
            onTap: ()=> onTap(),
            onLongPress: ()=> onLongPress!= null ? onLongPress!() : onTap(),
            child: Container(
                padding: padding,
                child: child
            ),
          ),
        ),
      ),
    );
  }
}


