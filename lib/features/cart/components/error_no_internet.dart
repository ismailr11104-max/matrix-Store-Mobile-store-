import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/features/cart/cubit/cart_cubit.dart';

class ErrorNoInternet extends StatelessWidget {
  const ErrorNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSized.w32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/no_internet.svg',
              width: AppSized.w160,
              height: AppSized.h160,
              fit: BoxFit.contain,
            ),
            SizedBox(height: AppSized.h32),
            Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSized.sp24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: AppSized.h12),

            Text(
              "It looks like you're offline. Please check\nyour internet connection and try again.",
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
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                    size: AppSized.r16,
                  ),
                  label: Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: AppSized.sp16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
