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
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            content: description,
            title: 'About me',
          ),
          TextFieldWidget(content: sex, title: 'Sex'),
          const SizedBox(height: 20),
          const Text(
            'Statistics',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF8378A1),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Liked users: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    TextSpan(
                      text: likedIds.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.red.shade200,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 25),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Matched users: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    TextSpan(
                      text: matchedIds.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
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
