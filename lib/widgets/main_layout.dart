import 'package:flutter/material.dart';
import 'package:lettutor/pages/discover_page.dart';
import 'package:lettutor/pages/history_page.dart';
import 'package:lettutor/pages/home_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedPage = 0;

  final _pageOptions = const [
    HomePage(),
    DiscoverPage(),
    SchedulePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showLogoutButton: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPage,
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
      ),
      body: _pageOptions[_selectedPage],
    );
  }

  _onTap(int index) {
    if (index == _selectedPage) return;

    setState(() {
      _selectedPage = index;
    });
  }
}
