import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app/core/dete_surce/local_dete/prefs_manager.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/features/auth/Sign_in_screen.dart';
import 'package:matrix_app/main.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;

    if (token != null) {
      options.headers["Authorization"] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigator.currentState!.context;
      UserRepository().delete();
      PrefManger().clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return SignInScreen();
          },
        ),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Session expired. Please log in again.")),
      );
    }

    handler.next(err);
  }
}
