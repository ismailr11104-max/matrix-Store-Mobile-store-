import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/features/cart/cart_screen.dart';
import 'package:matrix_app/features/cart/cubit/cart_injection.dart';
import 'package:matrix_app/features/category/category_screen.dart';
import 'package:matrix_app/features/home/home_screen.dart';
import 'package:matrix_app/features/profile_screen/cubit/profile_injection.dart';
import 'package:matrix_app/features/profile_screen/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  static final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    BlocProvider(
      create: (context) => CartInjection.getCubit(),
      child: const CartScreen(),
    ),
    BlocProvider(
      create: (context) => ProfileInjection.getCubit(),
      child: ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ? SvgPicture.asset(
                    'assets/images/tabler-icon-smart-home.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  )
                : SvgPicture.asset(
                    'assets/images/icon-smart-home.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? SvgPicture.asset(
                    'assets/images/tabler-icon-category.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  )
                : SvgPicture.asset(
                    'assets/images/icon-category.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? SvgPicture.asset(
                    'assets/images/tabler-icon-shopping-cart.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  )
                : SvgPicture.asset(
                    'assets/images/icon-shopping-cart.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? SvgPicture.asset(
                    'assets/images/tabler-icon-user.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  )
                : SvgPicture.asset(
                    'assets/images/icon-user.svg',
                    width: AppSized.w24,
                    height: AppSized.h24,
                  ),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
