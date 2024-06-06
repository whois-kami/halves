import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('Not logged in'));
    }
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No users found'));
            }
            final users = snapshot.data!.docs
                .where((userDoc) => userDoc.id != currentUser.uid)
                .toList();

            List<Container> userCards = users.map((userDoc) {
              var user = userDoc.data() as Map<String, dynamic>;
              return Container(
                width: 400,
                height: 600,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: user['photo'] == null || user['photo'].isEmpty
                        ? const AssetImage(
                            'lib/assets/images/search_screen/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                          ) as ImageProvider
                        : NetworkImage(user['photo'][0]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(user['name'] ?? 'No name'),
              );
            }).toList();

            return Center(
              child: userCards.isNotEmpty
                  ? CardSwiper(
                      cardsCount: userCards.length,
                      numberOfCardsDisplayed: userCards.length,
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          userCards[index],
                      onSwipe: (previousIndex, currentIndex, direction) =>
                          _onSwipe(
                        previousIndex,
                        currentIndex,
                        direction,
                        (currentIndex! - 1) == -1
                            ? users.last.id
                            : users[currentIndex - 1].id,
                      ),
                    )
                  : const Text('No users found'),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onSwipe(
      previousIndex, currentIndex, direction, String likedUserId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return false;
    }
    final currentUserId = currentUser.uid;
    if (direction == CardSwiperDirection.right) {
      context.read<SearchBloc>().add(SwipeRightEvent(
          currentUserId: currentUserId, likedUserId: likedUserId));
    }
    return true;
  }
}
