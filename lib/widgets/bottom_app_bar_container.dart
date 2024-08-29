import 'package:flutter/material.dart';

class BottomNavigationAppBar extends StatelessWidget {
  const BottomNavigationAppBar({super.key,
      required this.child,
      this.height = 68,
      this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
  });

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: BottomAppBar(
        height: height,
        padding: padding,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 10,
        child: child,
      ),
    );
  }
}
