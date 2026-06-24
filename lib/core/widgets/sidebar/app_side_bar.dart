import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_taxi/core/widgets/sidebar/models/side_bar_item_model.dart';
import 'package:my_taxi/core/widgets/sidebar/widgets/animated_drawer_tile.dart';
import 'package:my_taxi/core/widgets/sidebar/widgets/side_bar_footer.dart';
import 'package:my_taxi/core/widgets/sidebar/widgets/side_bar_header.dart';
import 'package:my_taxi/core/widgets/sidebar/widgets/side_bar_tile.dart';

class AppSideBar extends StatefulWidget {
  const AppSideBar({super.key});

  @override
  State<AppSideBar> createState() => _AppSideBarState();
}

class _AppSideBarState extends State<AppSideBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  int _activeIndex = -1;

  final List<SideBarItem> _mainItems = const [
    SideBarItem(
      icon: Icons.directions_car_rounded,
      label: 'My Rides',
      route: '/rides',
    ),
    SideBarItem(
      icon: Icons.account_balance_wallet_rounded,
      label: 'Wallet & Payment',
      route: '/wallet',
    ),
    SideBarItem(
      icon: Icons.favorite_rounded,
      label: 'Saved Places',
      route: '/saved',
    ),
  ];

  final List<SideBarItem> _secondaryItems = const [
    SideBarItem(
      icon: Icons.settings_rounded,
      label: 'Settings',
      route: '/settings',
    ),
    SideBarItem(
      icon: Icons.help_rounded,
      label: 'Help & Support',
      route: '/help',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _navigateTo({required String route, required int index}) {
    HapticFeedback.selectionClick();

    setState(() => _activeIndex = index);

    final navigator = Navigator.of(context);
    navigator.pop();

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      navigator.pushNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.72,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: colorScheme.surface,
        child: Column(
          children: [
            SideBarHeader(animController: _animController),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                physics: const BouncingScrollPhysics(),
                children: [
                  SectionLabel(
                    label: 'MENU',
                    animController: _animController,
                    delay: 0.15,
                  ),
                  ..._mainItems.asMap().entries.map((e) {
                    return AnimatedDrawerTile(
                      item: e.value,
                      index: e.key,
                      isActive: _activeIndex == e.key,
                      animController: _animController,
                      onTap: () => _navigateTo(
                        route: e.value.route,
                        index: e.key,
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  SideBarDivider(
                    animController: _animController,
                    delay: 0.5,
                  ),
                  const SizedBox(height: 8),
                  SectionLabel(
                    label: 'SUPPORT',
                    animController: _animController,
                    delay: 0.52,
                  ),
                  ..._secondaryItems.asMap().entries.map((e) {
                    final idx = _mainItems.length + e.key;
                    return AnimatedDrawerTile(
                      item: e.value,
                      index: idx,
                      isActive: _activeIndex == idx,
                      animController: _animController,
                      onTap: () => _navigateTo(
                        route: e.value.route,
                        index: idx,
                      ),
                    );
                  }),
                ],
              ),
            ),
            SideBarFooter(
              animController: _animController,
              onLogout: () {},
            ),
          ],
        ),
      ),
    );
  }
}
