import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(Icons.home, "Home", true),
          navItem(Icons.smart_toy, "Rashed", false),
          SizedBox(width: 40,),
        
          navItem(Icons.menu_book, "Message", false),
          navItem(Icons.person, "Profile", false),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
        color: isActive ? const Color(0xff5047E4) : const Color(0xff6B6868),
        ),
        Text(label, style: TextStyle(fontSize: 12,
        color: isActive ? const Color(0xff5047E4) : const Color(0xff6B6868),
        )),
      ],
    );
  }

}
