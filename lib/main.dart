import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/user/login.dart';
import 'package:flutter_application_1/screens/user/creation.dart';
import 'package:flutter_application_1/screens/user/profile.dart';
import 'package:flutter_application_1/screens/user/update/update_credentials.dart';
import 'package:flutter_application_1/screens/user/update/update_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDM 1',
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => const HomeScreen(),

        LoginScreen.routeName: (context) => LoginScreen(),
        UserCreationScreen.routeName: (context) => const UserCreationScreen(),
        ProfileScreen.routeName : (context) => const ProfileScreen(),
        UpdateCredentialsScreen.routeName : (context) => const UpdateCredentialsScreen(),
        UpdateUserPasswordScreen.routeName : (context) => const UpdateUserPasswordScreen(),
      },
    );
  }
}
