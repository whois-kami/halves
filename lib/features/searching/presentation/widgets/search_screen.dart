import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';
import 'package:halves/features/searching/presentation/widgets/user_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    context.read<SearchBloc>().add(CheckingNewMatchsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return Center(child: Text(AppTextConstants.searchNotLoginText));
    }
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is SearchLoaded) {
              if (state.isMatching == true) {
                _showMatchDialog(context, null);
              } else if (state.newMatches == true) {
                if (state.newMatchesCount != null &&
                    state.newMatchesCount != 0) {
                  _showMatchDialog(context, state.newMatchesCount);
                }
              }
            }
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(AppTextConstants.searchNoUsersFoundText));
              }

              var currentUserDoc = snapshot.data!.docs.firstWhere(
                (userDoc) => userDoc.id == currentUser.uid,
              );
              var currentUserSex = currentUserDoc.get('sex');
              List users;
              if (currentUserSex == 'male') {
                users = snapshot.data!.docs
                    .where((userDoc) =>
                        userDoc.id != currentUser.uid &&
                        userDoc.get('sex') != 'male')
                    .toList();
              } else {
                users = snapshot.data!.docs
                    .where((userDoc) =>
                        userDoc.id != currentUser.uid &&
                        userDoc.get('sex') != 'female')
                    .toList();
              }

              return Column(
                children: [
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
                        : Center(
                            child:
                                Text(AppTextConstants.searchNoUsersFoundText)),
                  ),
                ],
              );
            },
          ),
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
      await Future.delayed(const Duration(milliseconds: 500));
      context.read<ProfileBloc>().add(LoadProfileInfoEvent());
    } else if (direction == CardSwiperDirection.left) {
      log('Left right completed successfully.');
    }
    return true;
  }

  void _showMatchDialog(BuildContext context, int? countOfMatches) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('It\'s a Match!'),
          content: Text(countOfMatches != null
              ? 'You have $countOfMatches new match${countOfMatches > 1 ? "es" : ""}!'
              : 'You have a new match!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
