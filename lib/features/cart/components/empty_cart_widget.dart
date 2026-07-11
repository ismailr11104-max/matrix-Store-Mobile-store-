import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/features/button_navigation/main_navigation_screen.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSized.w32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/cart_empty.svg',
                  width: AppSized.w160,
                  height: AppSized.h160,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: AppSized.h32),
                Text(
                  "Your cart is empty!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSized.sp24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: AppSized.h12),

                Text(
                  "Looks like you haven't added anything yet.\nStart exploring the latest tech deals.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSized.sp14,
                    color: Colors.grey[500],
                    height: AppSized.h2,
                  ),
                ),
                SizedBox(height: AppSized.h32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSized.w24),
                  child: SizedBox(
                    height: AppSized.h48,
                    width: AppSized.w200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainNavigationScreen();
                            },
                          ),
                          (route) => false,
                        );
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              'Start Shopping',
                              style: TextStyle(
                                fontSize: AppSized.sp16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: AppSized.w8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: AppSized.r16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
