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
                backgroundColor: Colors.purple.withOpacity(0.5),
                labelStyle: const TextStyle(color: Colors.white),
                side: const BorderSide(color: Colors.transparent),
              ))
          .toList(),
    );
  }
}
