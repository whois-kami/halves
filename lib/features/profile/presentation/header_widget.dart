import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/core/constants/text_constants.dart';

class HeaderWidget extends StatelessWidget {
  final String? imageUrl;

  const HeaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            const Color(0xFF644E9F).withOpacity(0.5),
                            BlendMode.darken),
                      ),
                    ),
                  );
                },
              )
            : Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  image: DecorationImage(
                    image: const AssetImage(
                            'lib/assets/images/search_screen/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
                        as ImageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        const Color(0xFF644E9F).withOpacity(0.5),
                        BlendMode.darken),
                  ),
                ),
              ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                AppTextConstants.profileProfileTitleText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              const SizedBox(height: 40),
              IconButton(
                onPressed: () => context.go('/settings'),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageUrl != null
                      ? CachedNetworkImageProvider(imageUrl!)
                      : const AssetImage(
                              'lib/assets/images/search_screen/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
                          as ImageProvider, // Add your profile image here
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
