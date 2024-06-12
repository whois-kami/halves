import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/features/auth/presentation/widgets/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<bool> _checkUserExists() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .doc('users/${currentUser.uid}')
          .get();
      return doc.exists;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkUserExists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            context.go('/search');
          });
          return const SizedBox.shrink();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
