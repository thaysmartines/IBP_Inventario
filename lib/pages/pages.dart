import 'package:flutter/material.dart';
import 'package:invetario_flutter/pages/home_page.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Patrimônios',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Relatórios',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_2),
      label: 'QRCode',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Configurações',
    ),
  ];

  final List<Widget> _screens = [
    const Homepage(),
    Container(color: Colors.blue),
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
          Homepage(),
          Center(
            child: Text(
              'Learn 📗',
            ),
          ),
          Center(
            child: Text(
              'Relearn 👨‍🏫',
            ),
          ),
          Center(
            child: Text(
              'Unlearn 🐛',
            ),
          ),
        ][selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Patrimônios',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Learn',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.engineering),
              icon: Icon(Icons.engineering_outlined),
              label: 'Relearn',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Unlearn',
            ),
          ],
        ),
    );
  }
}
