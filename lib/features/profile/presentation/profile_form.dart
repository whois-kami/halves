import 'package:flutter/material.dart';
import 'package:halves/core/widgets/text_field_widget.dart';
import 'package:halves/features/profile/presentation/tags_widget.dart';

class ProfileFormWidget extends StatelessWidget {
  final String name;
  final String description;
  final int likedIds;
  final int matchedIds;
  final Map<String, dynamic> tags;
  final String sex;
  const ProfileFormWidget(
      {super.key,
      required this.name,
      required this.description,
      required this.likedIds,
      required this.matchedIds,
      required this.sex,
      required this.tags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(name),
          const SizedBox(height: 20),
          TextFieldWidget(content: description, title: 'About me'),
          TextFieldWidget(content: sex, title: 'Sex'),
          const SizedBox(height: 20),
          const Text('Statistycs'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Liked users: ${likedIds.toString()} '),
              const SizedBox(width: 20),
              Text('Matched users: ${matchedIds.toString()} '),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          const Text('Tags'),
          TagsWidget(tags: tags),
        ],
      ),
    );
  }
}
