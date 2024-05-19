import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

class MainSearchScreen extends StatelessWidget {
  const MainSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthBloc>().add(LoginOutEvent());
          context.go('/auth');
        },
        child: const Text('LogOut'),
      ),
    ));
  }
}
