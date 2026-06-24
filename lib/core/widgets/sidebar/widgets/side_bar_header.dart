import 'package:flutter/material.dart';

class SideBarHeader extends StatelessWidget {
  const SideBarHeader({
    super.key,
    required this.animController,
    this.userName = 'Saad Al-Khatib',
    this.userEmail = 'saad@mytaxi.app',
  });

  final AnimationController animController;
  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final fadeIn = CurvedAnimation(
      parent: animController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    final slideIn = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(fadeIn);

    return FadeTransition(
      opacity: fadeIn,
      child: SlideTransition(
        position: slideIn,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 96, 20, 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primary.withOpacity(0.78),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.onPrimary.withOpacity(0.18),
                  border: Border.all(
                    color: colorScheme.onPrimary.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: colorScheme.onPrimary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),

                    ),
                    const SizedBox(height: 2),
                    Text(
                      userEmail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
