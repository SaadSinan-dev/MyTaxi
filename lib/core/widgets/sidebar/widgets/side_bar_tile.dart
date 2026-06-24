import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({
    super.key,
    required this.label,
    required this.animController,
    this.delay = 0.0,
  });

  final String label;
  final AnimationController animController;
  final double delay;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final curved = CurvedAnimation(
      parent: animController,
      curve: Interval(
        delay.clamp(0.0, 1.0),
        (delay + 0.3).clamp(0.0, 1.0),
        curve: Curves.easeOut,
      ),
    );

    final slide = Tween<Offset>(
      begin: const Offset(-0.08, 0),
      end: Offset.zero,
    ).animate(curved);

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: slide,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
          ),
        ),
      ),
    );
  }
}

class SideBarDivider extends StatelessWidget {
  const SideBarDivider({
    super.key,
    required this.animController,
    this.delay = 0.0,
  });

  final AnimationController animController;
  final double delay;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final curved = CurvedAnimation(
      parent: animController,
      curve: Interval(
        delay.clamp(0.0, 1.0),
        (delay + 0.25).clamp(0.0, 1.0),
        curve: Curves.easeOut,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedBuilder(
        animation: curved,
        builder: (context, child) {
          return Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: curved.value,
              child: Container(
                height: 1,
                color: colorScheme.onSurface.withOpacity(0.08),
              ),
            ),
          );
        },
      ),
    );
  }
}
