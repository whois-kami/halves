import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';
import 'package:halves/features/searching/presentation/widgets/user_card_widget.dart';

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

            return Column(
              children: [
                // Insert your image here
                Image.asset(
                  r'lib\assets\images\onboarding_screens\halves-logo.png',
                  height: 60,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: users.isNotEmpty
                      ? CardSwiper(
                          cardsCount: users.length,
                          numberOfCardsDisplayed: 2,
                          cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) {
                            final currentUser = users[index];
                            return UserCardWidget(
                              user: currentUser,
                            );
                          },
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
                      : const Center(child: Text('No users found')),
                ),
              ],
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
