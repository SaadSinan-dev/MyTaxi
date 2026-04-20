import 'package:flutter/material.dart';
import 'package:my_taxi/core/app_colors.dart'; 
import 'sidebar_item_model.dart';

class AnimatedDrawerTile extends StatefulWidget {
  final SideBarItem item;
  final int index;
  final bool isActive;
  final AnimationController animController;
  final VoidCallback onTap;

  const AnimatedDrawerTile({
    super.key,
    required this.item,
    required this.index,
    required this.isActive,
    required this.animController,
    required this.onTap,
  });

  @override
  State<AnimatedDrawerTile> createState() => _AnimatedDrawerTileState();
}

class _AnimatedDrawerTileState extends State<AnimatedDrawerTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 280),
    );
    // Subtle scale — feels responsive but not jarring
    _pressScale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Staggered entrance: each tile starts 60ms after the previous one.
    const baseDelay = 0.18; // when the first tile starts
    const step = 0.065; // gap between each tile
    const duration = 0.42; // how long each tile's own animation runs

    final start = (baseDelay + widget.index * step).clamp(0.0, 0.85);
    final end = (start + duration).clamp(0.0, 1.0);

    final entranceAnim = CurvedAnimation(
      parent: widget.animController,
      curve: Interval(start, end, curve: Curves.easeOutQuart),
    );

    return FadeTransition(
      opacity: entranceAnim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.08, 0),
          end: Offset.zero,
        ).animate(entranceAnim),
        child: ScaleTransition(
          scale: _pressScale,
          child: GestureDetector(
            onTapDown: (_) => _pressController.forward(),
            onTapUp: (_) => _pressController.reverse(),
            onTapCancel: () => _pressController.reverse(),
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: widget.isActive
                    ? Border.all(
                        color: AppColors.primary.withOpacity(0.25),
                        width: 1,
                      )
                    : Border.all(color: Colors.transparent),
              ),
              child: Row(
                children: [
                  // Icon box
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.isActive
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        widget.item.icon,
                        key: ValueKey(widget.isActive),
                        size: 20,
                        color: widget.isActive
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Label
                  Expanded(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: widget.isActive
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: widget.isActive
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        letterSpacing: 0.1,
                      ),
                      child: Text(widget.item.label),
                    ),
                  ),

                  // Badge or chevron
                  if (widget.item.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.item.badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    AnimatedOpacity(
                      opacity: widget.isActive ? 1.0 : 0.3,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: widget.isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}