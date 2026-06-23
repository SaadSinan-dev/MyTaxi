import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  final AnimationController animController;
  final double delay;

  const SectionLabel({
    super.key,
    required this.label,
    required this.animController,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(
      parent: animController,
      curve: Interval(delay, (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: anim,
      child: Padding(
        padding: const EdgeInsets.only(left: 26, top: 8, bottom: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary.withOpacity(0.6),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class SideBarDivider extends StatelessWidget {
  final AnimationController animController;
  final double delay;

  const SideBarDivider({
    super.key,
    required this.animController,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(
      parent: animController,
      curve: Interval(delay, (delay + 0.25).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: anim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Divider(
          color: AppColors.border.withOpacity(0.6),
          thickness: 1,
          height: 1,
        ),
      ),
    );
  }
}

class StatChip extends StatelessWidget {
  final String label;
  final String value;

  const StatChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      color: Colors.white.withOpacity(0.2),
    );
  }
}
