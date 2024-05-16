import 'package:flutter/material.dart';

class AuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('asd'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
