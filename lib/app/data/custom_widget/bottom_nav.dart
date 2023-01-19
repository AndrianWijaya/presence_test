import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';

ConvexAppBar bottomNavigation({int? initialActiveIndex, Function(int)? onTap}) {
  return ConvexAppBar(
        gradient: LinearGradient(colors: [blue1, blue2]),
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home_rounded, title: "Home"),
          TabItem(icon: Icons.fingerprint_rounded),
          TabItem(icon: Icons.person_rounded, title: "Profile"),
        ],
        initialActiveIndex: initialActiveIndex,
        onTap: onTap,
      );
}