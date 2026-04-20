import 'package:flutter/material.dart';

class SideBarItem {
  final IconData icon;
  final String label;
  final String route;
  final String? badge;

  const SideBarItem({
    required this.icon,
    required this.label,
    required this.route,
    this.badge,
  });
}