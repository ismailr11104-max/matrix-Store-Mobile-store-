import 'package:matrix_app/features/profile_screen/cubit/profile_cubit.dart';
import 'package:matrix_app/features/profile_screen/date/remut_date/user_api_serves.dart';
import 'package:matrix_app/features/profile_screen/rope/profile_repository.dart';

class ProfileInjection {
  static ProfileCubit getCubit() {
    return ProfileCubit(ProfileRepository(UserApiServes()));
  }
}
