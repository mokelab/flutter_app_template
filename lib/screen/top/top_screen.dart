import 'package:flutter/material.dart';
import 'package:template/screen/article/article_list_screen.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TopScreenState();
}

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
