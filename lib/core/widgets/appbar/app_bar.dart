import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/core/fonts/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final bool showDrawerToggle;
  final VoidCallback? onBackPressed;
  final VoidCallback? onDrawerToggle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBottomBorder;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.showDrawerToggle = false,
    this.onBackPressed,
    this.onDrawerToggle,
    this.actions,
    this.leading,
    this.showBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final topPadding = MediaQuery.of(context).padding.top;

    Widget leftWidget;
    if (showDrawerToggle) {
      leftWidget = _DrawerToggleButton(
        onTap: onDrawerToggle ?? () => Scaffold.of(context).openDrawer(),
      );
    } else if (showBackButton && canPop) {
      leftWidget = _AppBarIconButton(
        onTap: onBackPressed ?? () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18,
        ),
      );
    } else if (leading != null) {
      leftWidget = leading!;
    } else {
      leftWidget = const SizedBox(width: 48);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        margin: EdgeInsets.only(top: topPadding + 0, left: 16, right: 16),
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              leftWidget,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppFonts.english,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null && actions!.isNotEmpty)
                Row(mainAxisSize: MainAxisSize.min, children: actions!)
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);
}

class _DrawerToggleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DrawerToggleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _AppBarIconButton(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: const Icon(
        Icons.segment_outlined,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _AppBarIconButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.white.withOpacity(0.1),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool showBadge;
  final String? badgeCount;

  const AppBarAction({
    super.key,
    required this.icon,
    required this.onTap,
    this.showBadge = false,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return _AppBarIconButton(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          if (showBadge)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
