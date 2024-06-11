import 'package:flutter/material.dart';

class TagsWidget extends StatelessWidget {
  final Map<String, dynamic> tags;

  const TagsWidget({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags.entries
          .where((entry) => entry.value != false)
          .map<Widget>((entry) => Chip(
                label: Text(entry.key),
                backgroundColor: const Color(0xFF1E1E1E),
                labelStyle: const TextStyle(color: Colors.white),
                side: const BorderSide(color: Colors.white),
              ))
          .toList(),
    );
  }
}
