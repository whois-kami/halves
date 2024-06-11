import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final String content;

  const TextFieldWidget({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF8378A1),
          ),
        ),
        const SizedBox(height: 3),
        Text(content),
        Divider(
          thickness: 1,
          color: Colors.white.withOpacity(0.3),
        ),
      ],
    );
  }
}
