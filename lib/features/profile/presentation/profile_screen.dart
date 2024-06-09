import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:halves/features/profile/presentation/header_widget.dart';
import 'package:halves/features/profile/presentation/profile_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadProfileInfoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is ProfileLoaded) {
            final currentUser = state.profile;
            return SingleChildScrollView(
              child: Column(
                children: [
                  HeaderWidget(
                    imageUrl: currentUser.photos.lastOrNull,
                  ),
                  ProfileFormWidget(
                    name: currentUser.name,
                    description: currentUser.description,
                    likedIds: currentUser.likedIds.length,
                    matchedIds: currentUser.matchedIds.length,
                    sex: currentUser.sex,
                    tags: currentUser.tags,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
