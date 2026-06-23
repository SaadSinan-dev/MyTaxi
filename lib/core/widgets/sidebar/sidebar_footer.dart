import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class SideBarFooter extends StatefulWidget {
  final AnimationController animController;

  const SideBarFooter({super.key, required this.animController});

  @override
  State<SideBarFooter> createState() => _SideBarFooterState();
}

class _SideBarFooterState extends State<SideBarFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  bool pressing = false;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Footer slides up from below after items have settled
    final entranceAnim = CurvedAnimation(
      parent: widget.animController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: entranceAnim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(entranceAnim),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                Text(
                  'MyTaxi v1.0.0',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 10),

                // Logout
                GestureDetector(
                  onTapDown: (_) {
                    setState(() => pressing = true);
                    _pressController.forward();
                  },
                  onTapUp: (_) {
                    setState(() => pressing = false);
                    _pressController.reverse();
                    HapticFeedback.mediumImpact();
                    // Handle logout
                  },
                  onTapCancel: () {
                    setState(() => pressing = false);
                    _pressController.reverse();
                  },
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.97).animate(
                      CurvedAnimation(
                        parent: _pressController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
