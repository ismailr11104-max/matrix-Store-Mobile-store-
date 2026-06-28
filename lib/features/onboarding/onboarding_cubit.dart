import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  PageController pageController = PageController();
  void onPageChange(int index) {
    if (index == 2) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
    } else {
      emit(state.copyWith(currentIndex: index, isLastPage: false));
    }
  }
}
