import 'package:flutter/material.dart';

const Curve _butterCurve = Cubic(0.22, 0.61, 0.16, 1.0);

Route createRoute(Widget passedClass, double dx, double dy) {
  final useDefaultOffset = dx == 0.0 && dy == 0.0;
  final beginOffset = useDefaultOffset ? const Offset(0.0, 0.04) : Offset(dx, dy);

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) => passedClass,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: _butterCurve);

      final slide = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(curved);

      // Subtle scale-in (0.97 -> 1.0) is what sells the "smooth/heavy" feel
      // without being noticeable as a separate effect.
      final scale = Tween<double>(begin: 0.97, end: 1.0).animate(curved);

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: slide,
          child: ScaleTransition(
            scale: scale,
            child: child,
          ),
        ),
      );
    },
  );
}
