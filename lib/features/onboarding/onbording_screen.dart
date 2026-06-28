import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/dete_surce/prefs_manager.dart';
import 'package:matrix_app/features/auth/Sign_in_screen.dart';
import 'package:matrix_app/features/onboarding/model/onboarding_model.dart';
import 'package:matrix_app/features/onboarding/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  void _onFinish(BuildContext context, Widget targetScreen) async {
    await PrefManger().setBool('onboarding_completed', true);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return targetScreen;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final controller = context.read<OnboardingCubit>();
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        controller.onPageChange(index);
                      },
                      itemCount: OnboardingModel.onboarding.length,
                      itemBuilder: (BuildContext context, int index) {
                        final OnboardingModel models =
                            OnboardingModel.onboarding[index];
                        return Column(
                          children: [
                            SizedBox(height: 46),
                            Expanded(
                              child: Image.asset(
                                models.image,
                                width: 350,
                                height: 300,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              models.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(height: 10),

                            Text(
                              models.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                      spacing: 8.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Color(0xFFE5E7EB),
                      activeDotColor: Color(0xFF776FE7),
                    ),
                  ),
                  SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.isLastPage) {
                          _onFinish(context, SignInScreen());
                        } else {
                          controller.pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      child: Text(
                        state.isLastPage ? 'Sig In' : 'Next',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 58,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        if (state.isLastPage) {
                          _onFinish(context, SignInScreen());
                        } else {
                          _onFinish(context, SignInScreen());
                        }
                      },
                      child: Text(
                        state.isLastPage ? 'Sin Up' : 'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
