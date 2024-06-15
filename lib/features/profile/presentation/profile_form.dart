import 'package:flutter/material.dart';
import 'package:halves/core/constants/text_constants.dart';
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            content: description,
            title: AppTextConstants.profileAboutMeText,
          ),
          TextFieldWidget(
            content: sex,
            title: AppTextConstants.profileSexText,
          ),
          const SizedBox(height: 20),
          Text(
            'Statistics',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppTextConstants.profileLikedUsersText,
                      style: const TextStyle(
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
                      text: AppTextConstants.profileMathcedUsersText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    TextSpan(
                      text: matchedIds.toString(),
                      style: const TextStyle(
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
          Text(
            AppTextConstants.profileTagsText,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          TagsWidget(tags: tags),
        ],
      ),
    );
  }
}
