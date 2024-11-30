import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  NavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
