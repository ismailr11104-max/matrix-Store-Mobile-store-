import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_app/core/dete_surce/local_dete/cart_local_data.dart';
import 'package:matrix_app/core/dete_surce/local_dete/prefs_manager.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/features/favorites/date/local_date/favorite_local_date.dart';
import 'package:matrix_app/features/splash/splash_screen.dart';

import 'core/theme/light_theme.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PrefManger().init();
  await UserRepository().init();
  await CartLocalData().init();
  await FavoritesLocalData().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigator,
          debugShowCheckedModeBanner: false,
          title: 'Matrix App',
          theme: lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
