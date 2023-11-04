import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        _onNavigationBarTap(index, context);
      },
      unselectedItemColor: Colors.grey[600],
      selectedItemColor: Theme.of(context).primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }

  _onNavigationBarTap(int index, BuildContext context) {
    // if (index == currentIndex) return;

    String dest;

    switch (index) {
      case 0:
        dest = "home";
        break;
      case 1:
        dest = "discover";
        break;
      case 2:
        dest = "schedule";
        break;
      case 3:
        dest = "history";
        break;
      default:
        dest = "home";
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      dest,
      (route) => false,
    );
  }
}
