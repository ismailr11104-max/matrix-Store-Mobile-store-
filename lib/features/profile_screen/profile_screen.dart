import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/local_dete/prefs_manager.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/features/auth/Sign_in_screen.dart';
import 'package:matrix_app/features/favorites/favorites_screen.dart';
import 'package:matrix_app/features/profile_screen/cubit/profile_injection.dart';
import 'package:matrix_app/features/profile_screen/edit_profile.dart';

import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInjection.getCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyActions: false,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.profileStatus == RequestStatus.error &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.profileStatus == RequestStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF5C7CFA)),
              );
            }
            final user = state.userModel;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSized.w24),
                child: Column(
                  children: [
                    SizedBox(height: AppSized.h24),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(AppSized.r3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF5C7CFA),
                            width: AppSized.r3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: AppSized.r60,
                          backgroundColor: Colors.grey,
                          backgroundImage: state.userModel?.imageUser != null
                              ? FileImage(File(state.userModel!.imageUser!))
                                    as ImageProvider
                              : const AssetImage(
                                  'assets/images/path_ismail.png',
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSized.h16),
                    Text(
                      user?.name ?? 'No Name Added',
                      style: TextStyle(
                        fontSize: AppSized.sp24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1D20),
                      ),
                    ),
                    SizedBox(height: AppSized.h6),
                    Text(
                      user?.email ?? 'No Email',
                      style: TextStyle(
                        fontSize: AppSized.sp14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppSized.h24),
                    const Divider(color: Color(0xFFF1F3F5), thickness: 1.5),
                    SizedBox(height: AppSized.h16),
                    _itemListTiel(
                      "Edit Profile",
                      "assets/images/user_icon.svg",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext _) {
                              return BlocProvider.value(
                                value: context.read<ProfileCubit>(),
                                child: EditProfile(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    _itemListTiel(
                      "Favorite",
                      "assets/images/favorite_icon.svg",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return FavoritesScreen();
                            },
                          ),
                        );
                      },
                    ),
                    _itemListTiel(
                      "Setting",
                      "assets/images/setting.svg",
                      () {},
                    ),

                    SizedBox(height: AppSized.h8),
                    const Divider(color: Color(0xFFF1F3F5), thickness: 1.5),
                    SizedBox(height: AppSized.h16),

                    _itemListTiel(
                      "Information",
                      "assets/images/Information_icon.svg",
                      () {},
                    ),
                    _itemListTiel(
                      "Log Out",
                      "assets/images/log_out_icon.svg",
                      () async {
                        await PrefManger().clear();
                        await PrefManger().setBool("is_logged_in", false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SignInScreen();
                            },
                          ),
                          (predicate) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _itemListTiel(
    String title,
    String path,
    Function() onTap, {
    Color color = const Color(0xFF161F1B),
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: AppSized.sp16,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: SvgPicture.asset(
            path,
            width: AppSized.w32,
            height: AppSized.h32,
          ),
          trailing: Icon(Icons.chevron_right, size: AppSized.r24, color: color),
        ),
      ],
    );
  }
}
