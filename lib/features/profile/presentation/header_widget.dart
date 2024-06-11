import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWidget extends StatelessWidget {
  final String? imageUrl;

  const HeaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple,
            image: DecorationImage(
              image: imageUrl != null
                  ? NetworkImage(imageUrl!)
                  : const AssetImage(
                          'lib/assets/images/search_screen/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
                      as ImageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color(0xFF644E9F).withOpacity(0.5), BlendMode.darken),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              SizedBox(height: 40),
              IconButton(
                onPressed: () => context.go('/profile/settings'),
                icon: Icon(
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
                      ? NetworkImage(imageUrl!)
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
