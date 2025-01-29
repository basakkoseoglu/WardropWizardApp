import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Arka plan rengi
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Yuvarlak kenarlar (üst kısım)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Hafif gölge
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -3), // Yukarı doğru gölge
          ),
        ],
      ),
      child: GNav(
        color: Theme.of(context).colorScheme.inversePrimary,
        activeColor: Theme.of(context).colorScheme.secondary,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(
            icon: Icons.diamond_outlined,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            icon: Icons.checkroom,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            icon: Icons.search,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            icon: Icons.info,
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
