import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account"),
        ],
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

/*
class _TopScreenState extends State<TopScreen> {
  int _currentTabIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ArticleListScreen(),
      Container(),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), label: "Account"),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          items: bottomNavigationItems,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
        ),
        body: _screens[_currentTabIndex]);
  }
}

*/