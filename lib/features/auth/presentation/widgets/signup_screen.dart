import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:halves/core/constants/style_constants.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/core/styles/app_theme.dart';
import 'package:halves/features/auth/domain/entities/user_entity.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          context.go('/chooseSex');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppThemeData.halvesTheme.scaffoldBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  r'lib\assets\images\onboarding_screens\scaffold-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Image(
                width: 400,
                height: 270,
                image:
                    AssetImage(r'lib\assets\images\auth_screens\sign-up.png'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppTextConstants.signUpWelcomeText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: AppTextConstants.signUpHelpText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    _SignUpLoginFormWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpLoginFormWidget extends StatefulWidget {
  const _SignUpLoginFormWidget({super.key});

  @override
  State<_SignUpLoginFormWidget> createState() => __SignUpLoginFormWidgetState();
}

class __SignUpLoginFormWidgetState extends State<_SignUpLoginFormWidget> {
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController confirmPassController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          cursorErrorColor: Colors.white,
          decoration: AppStyleConstants.emailInputDecorationStyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passController,
          cursorColor: Colors.white,
          cursorErrorColor: Colors.white,
          decoration: AppStyleConstants.passInputDecorationStyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: confirmPassController,
          cursorColor: Colors.white,
          cursorErrorColor: Colors.white,
          decoration: AppStyleConstants.confirmInputDecorationStyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        _BottomSignUpWidget(
          emailController: emailController,
          passController: passController,
          confirmPassController: confirmPassController,
        ),
      ],
    );
  }
}

class _BottomSignUpWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  const _BottomSignUpWidget({
    super.key,
    required this.emailController,
    required this.passController,
    required this.confirmPassController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: AppStyleConstants.elevatedAuthButtonStyle,
          onPressed: () {
            if (passController.text != confirmPassController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppTextConstants.signUpErrorPassSame),
                ),
              );
            } else {
              _signUpUser(context);
            }
          },
          child: Text(
            AppTextConstants.signUpGoButton,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppTextConstants.signUpSignInText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () => context.go('/auth'),
              child: Text(
                AppTextConstants.signInGoButton,
                style: AppStyleConstants.logSigTextButton,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _signUpUser(BuildContext context) {
    final email = emailController.text;
    final password = passController.text;
    UserData userData = UserData(email: email, passWord: password);
    context.read<AuthBloc>().add(SignUpEvent(personData: userData));
  }
}
