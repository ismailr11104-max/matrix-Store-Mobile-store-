import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/api_dio_config.dart';
import 'package:matrix_app/core/dete_surce/remote_dete/auth/auth_api_service.dart';
import 'package:matrix_app/core/enum/request_status.dart';
import 'package:matrix_app/core/widgets/custom_text_from_field.dart';
import 'package:matrix_app/features/auth/Sign_up_screen.dart';
import 'package:matrix_app/features/auth/cubit/auth_cubit.dart';
import 'package:matrix_app/features/auth/repo/auth_repository.dart';
import 'package:matrix_app/features/button_navigation/main_navigation_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(AuthRepository(AuthApiService(ApiDioConfig.createDio()))),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSized.w24),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (BuildContext context, AuthState state) {
                  if (state.authStatus == RequestStatus.laded) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                    );
                  } else if (state.authStatus == RequestStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? "حدث خطأ ما"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSized.h60),
                        Center(
                          child: Image.asset(
                            'assets/images/logo_matrix.png',
                            width: AppSized.w140,
                          ),
                        ),

                        SizedBox(height: AppSized.h45),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: AppSized.sp28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        SizedBox(height: AppSized.h8),
                        Text(
                          'Sign in for a premium tech experience',
                          style: TextStyle(
                            fontSize: AppSized.sp14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: AppSized.h24),
                        CustomTextFromField(
                          controller: emailController,
                          hintText: "wilson07@gmail.com",
                          title: "Email",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter Email";
                            }
                            // final RegExp emailRegex = RegExp(
                            //   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            // );
                            // if (!emailRegex.hasMatch(value)) {
                            //   return "Please Enter a valid email";
                            // }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSized.h24),
                        CustomTextFromField(
                          controller: passwordController,
                          hintText: "*********",
                          title: "Password",
                          maxLines: 1,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter Password";
                            }
                            // final passwordRegex = RegExp(
                            //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
                            // );
                            //
                            // if (!passwordRegex.hasMatch(value)) {
                            //   return "Weak password (must include upper, lower, number)";
                            // }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color(0xFF776FE7),
                                fontSize: AppSized.sp12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: AppSized.h24),
                        SizedBox(
                          width: double.infinity,
                          height: AppSized.h56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().sign_in(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: state.authStatus == RequestStatus.loading
                                ? SizedBox(
                                    width: AppSized.w20,
                                    height: AppSized.h20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: AppSized.sp16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: AppSized.h24),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: AppSized.sp14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SignUpScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Color(0xFF776FE7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSized.sp14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSized.h20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
