import 'package:flutter/material.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/widgets/custom_text_from_field.dart';
import 'package:matrix_app/features/home/home_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSized.w24),
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
                      if (_key.currentState?.validate() == false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      }
                    },
                    child: Text(
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
                        onTap: () {},
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
          ),
        ),
      ),
    );
  }
}
