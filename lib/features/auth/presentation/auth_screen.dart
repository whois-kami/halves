import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:halves/features/auth/presentation/widgets/auth_appBar.dart';
import 'package:halves/features/auth/presentation/widgets/body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const Scaffold(
        appBar: AuthAppbar(),
        body: Body(),
      ),
    );
  }
}
