import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserContactWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserContactWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/chatWith/${user['id']}'),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFF565556),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user['photo'][0]),
              radius: 35,
            ),
            const SizedBox(width: 20),
            Text(
              user['name'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
