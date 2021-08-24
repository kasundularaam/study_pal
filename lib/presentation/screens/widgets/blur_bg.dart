import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBg extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  const BlurBg({
    Key? key,
    required this.child,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: child,
      ),
    );
  }
}