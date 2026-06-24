import 'package:flutter/material.dart';
import 'package:my_taxi/core/widgets/sidebar/models/side_bar_item_model.dart';

class AnimatedDrawerTile extends StatefulWidget {
  const AnimatedDrawerTile({
    super.key,
    required this.item,
    required this.index,
    required this.isActive,
    required this.animController,
    required this.onTap,
  });

  final SideBarItem item;
  final int index;
  final bool isActive;
  final AnimationController animController;
  final VoidCallback onTap;

  @override
  State<AnimatedDrawerTile> createState() => _AnimatedDrawerTileState();
}

class _AnimatedDrawerTileState extends State<AnimatedDrawerTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final startDelay = (0.55 + widget.index * 0.08).clamp(0.0, 0.9);
    final endDelay = (startDelay + 0.3).clamp(0.0, 1.0);

    final curved = CurvedAnimation(
      parent: widget.animController,
      curve: Interval(startDelay, endDelay, curve: Curves.easeOutCubic),
    );

    final slide = Tween<Offset>(
      begin: const Offset(-0.25, 0),
      end: Offset.zero,
    ).animate(curved);

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: slide,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onTap: widget.onTap,
            child: AnimatedScale(
              scale: _isPressed ? 0.97 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? colorScheme.primary.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 4,
                      height: widget.isActive ? 20 : 0,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: widget.isActive ? 10 : 0),
                    Icon(
                      widget.item.icon,
                      size: 22,
                      color: widget.isActive
                          ? colorScheme.primary
                          : colorScheme.onSurface.withOpacity(0.65),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        widget.item.label,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: widget.isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: widget.isActive
                              ? colorScheme.primary
                              : colorScheme.onSurface.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
