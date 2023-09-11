import 'package:amazon/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:amazon/routs.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/service/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Provides the UserProvider instance to the widget tree
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Fetches user data using the AuthService instance
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazon',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
              
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
          // Handles routing based on conditions
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const SplashScreen(),
        );
      },
    );
  }
}
