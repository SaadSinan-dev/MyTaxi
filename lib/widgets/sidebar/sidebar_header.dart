import 'package:flutter/material.dart';
import 'package:my_taxi/core/app_colors.dart';
import 'sidebar_components.dart';

class SideBarHeader extends StatelessWidget {
  final AnimationController animController;

  const SideBarHeader({super.key, required this.animController});

  @override
  Widget build(BuildContext context) {
    // Header fades + slides in during the first 50% of the timeline
    final anim = CurvedAnimation(
      parent: animController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.06),
          end: Offset.zero,
        ).animate(anim),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 28,
            bottom: 28,
            left: 24,
            right: 24,
          ),
          decoration: const BoxDecoration(color: AppColors.primary),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                // Avatar with ring + online dot
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saad Senan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '+967 7X XXX XXXX',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // Edit profile button
              ],
            ),
            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
