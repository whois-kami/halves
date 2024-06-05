import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/core/constants/style_constants.dart';
import 'package:halves/features/auth/domain/entities/user_entity.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          context.go('/search');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Container(
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
              image: AssetImage(r'lib\assets\images\auth_screens\login.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Namastey!\n',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    TextSpan(
                      text:
                          '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse habitant maecenas ipsum tellus cras faucibus lectus ultrices. Odio scelerisque purus ipsum, tristique.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: _LoginFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginFormWidget extends StatefulWidget {
  const _LoginFormWidget({super.key});

  @override
  State<_LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<_LoginFormWidget> {
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
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
          decoration: AppConstants.emailInputDecorationStyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          controller: passController,
          cursorColor: Colors.white,
          cursorErrorColor: Colors.white,
          decoration: AppConstants.passInputDecorationStyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Your Password?',
            style: TextStyle(color: Color(0xFFFF08A7), letterSpacing: 1),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _LoginButtonWidget(
          emailController: emailController,
          passController: passController,
        ),
      ],
    );
  }
}

class _LoginButtonWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passController;

  const _LoginButtonWidget({
    super.key,
    required this.emailController,
    required this.passController,
  });

  @override
  State<_LoginButtonWidget> createState() => __LoginButtonWidgetState();
}

class __LoginButtonWidgetState extends State<_LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: AppConstants.elevatedAuthButtonStyle,
          onPressed: () => _signInUser(context),
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () => context.go('/auth/signup'),
              child: Text(
                'Sign up',
                style: AppConstants.logSigTextButton,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _signInUser(BuildContext context) {
    final email = widget.emailController.text;
    final password = widget.passController.text;
    UserData userData = UserData(email: email, passWord: password);
    context.read<AuthBloc>().add(LoginEvent(personData: userData));
  }
}
