import 'package:flutter/material.dart';

class TagsUserWidget extends StatelessWidget {
  final Map<String, dynamic> tags;

  const TagsUserWidget({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags.entries
          .where((entry) => entry.value != false)
          .take(2)
          .map<Widget>((entry) => SizedBox(
                height: 35,
                child: Chip(
                  avatar: const Icon(Icons.done, size: 15, color: Colors.white),
                  label: Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  backgroundColor: const Color(0xFF644E9F),
                  labelStyle: const TextStyle(color: Colors.white),
                  side: const BorderSide(color: Colors.white, width: 1),
                ),
              ))
          .toList(),
    );
  }
}
