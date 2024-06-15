import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halves/features/searching/presentation/widgets/tags_user_widget.dart';

class UserCardWidget extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> user;
  const UserCardWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final userData = user.data() as Map<String, dynamic>;
    return Container(
      width: 400,
      height: 600,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF644E9F),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: user['photo'] == null || user['photo'].isEmpty
                  ? Image.asset(
                      'lib/assets/images/search_screen/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                      fit: BoxFit.cover,
                      width: 400,
                      height: 600,
                    )
                  : CachedNetworkImage(
                      imageUrl: user['photo'][0],
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 400,
                          height: 600,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        );
                      },
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
          ),
          Positioned(
            left: 0,
            height: 30,
            child: Container(
              width: 70,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(25),
                ),
                color: Color(0xFF644E9F),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_back_sharp,
                    size: 16,
                    color: Colors.white,
                  ),
                  Text(
                    'Нет!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            height: 30,
            child: Container(
              width: 70,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(25),
                ),
                color: Color(0xFF644E9F),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'Да!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userData['name'] ?? 'No name'}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${userData['description'] ?? ''}',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 20,
            child: TagsUserWidget(tags: userData['tags'] ?? ''),
          )
        ],
      ),
    );
  }
}
