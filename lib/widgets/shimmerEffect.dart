import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffects extends StatelessWidget {
  Widget child;

  ShimmerEffects({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      direction: ShimmerDirection.ltr,
      baseColor: Colors.white,
      highlightColor: Colors.deepPurple.shade700,

    );
  }
}
