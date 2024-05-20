import 'package:flutter/material.dart';
import 'package:tech_says_no/shared_prefs.dart';
import 'package:tech_says_no/widgets/add_contact.dart';
import 'package:tech_says_no/widgets/home.dart';
import 'package:tech_says_no/widgets/login.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const AddContact(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTap,
        destinations: const [
           NavigationDestination(
              icon: Icon(
               Icons.home,
              ),
              label: "Home"),
          NavigationDestination(
              icon: Icon(
                Icons.contact_emergency
              ),
              label:"Contacts"),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
