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
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: child,
      ),
    );
  }
}
