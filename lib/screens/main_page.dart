import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tourist/screens/favorite_page.dart';
import 'package:tourist/screens/home_screen.dart';
import 'package:tourist/screens/profile_page.dart';
import 'package:tourist/screens/search_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      FavoritePage(),
      HomeScreen(
        onSearch: () => setState(() {
          _selectedIndex = 2;
        }),
      ),
      SearchScreen(),
      ProfilePage(),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: StylishBottomBar(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        backgroundColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.backgroundColor,
        option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text('Favorites'),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text('Home'),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text('search'),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
