import 'package:flutter/material.dart';

class SideBarItem {
  const SideBarItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}
