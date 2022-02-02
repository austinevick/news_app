import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/screens/bottom_navigation_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/signup_screen.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User?>(
      stream: AuthProvider.authCurrentState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SignUpScreen();
        } else if (snapshot.hasData) {
          return const BottomNavigationScreen();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }
}
