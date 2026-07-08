import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/features/cart/cart_screen.dart';
import 'package:matrix_app/features/category/category_screen.dart';
import 'package:matrix_app/features/home/home_screen.dart';
import 'package:matrix_app/features/profile_screen/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF776FE7),
        unselectedItemColor: const Color(0xFF000000),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? SvgPicture.asset('assets/images/tabler-icon-smart-home.svg ')
                : SvgPicture.asset('assets/images/icon-smart-home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? SvgPicture.asset('assets/images/tabler-icon-category.svg')
                : SvgPicture.asset(' assets/images/icon-category.svg'),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? SvgPicture.asset(
                    'assets/images/tabler-icon-shopping-cart.svg ',
                  )
                : SvgPicture.asset('assets/images/icon-shopping-cart.svg'),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? SvgPicture.asset('assets/images/tabler-icon-user.svg ')
                : SvgPicture.asset('assets/images/icon-user.svg'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
