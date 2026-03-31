import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(Icons.home, "Home", 0),
          navItem(Icons.smart_toy, "Rashed", 1),
          SizedBox(width: 40),

          navItem(Icons.menu_book, "Message", 3),
          navItem(Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xff5047E4) : const Color(0xff6B6868),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xff5047E4) : const Color(0xff6B6868),
            ),
          ),
        ],
      ),
    );
  }
}
