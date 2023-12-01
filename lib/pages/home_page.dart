import 'package:flutter/material.dart';
import 'package:lettutor/pages/discover_page.dart';
import 'package:lettutor/pages/history_page.dart';
import 'package:lettutor/pages/profile_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/pages/tutor_list_page.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

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
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: const [
          TutorListPage(),
          DiscoverPage(),
          SchedulePage(),
          HistoryPage(),
          ProfilePage(),
        ],
      ),
    );
  }

  _onTap(int index) {
    if (index == _selectedPage) return;

    setState(() {
      _selectedPage = index;
    });
  }
}
