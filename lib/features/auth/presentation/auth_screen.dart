import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halves/features/auth/presentation/widgets/login_screen.dart';
import 'package:halves/features/searching/presentation/widgets/asdsad.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainSearchScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
