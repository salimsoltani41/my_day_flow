import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double borderRadius = 20;
  final bool colorBorder;
  const GlassContainer({
    this.colorBorder = true,
    super.key,
    required this.child,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: height,
          padding: padding ?? EdgeInsets.all(24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(borderRadius),
            border: colorBorder
                ? Border.all(color: Colors.white.withAlpha(50), width: 1.5)
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
