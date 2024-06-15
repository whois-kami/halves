import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:halves/features/messaging/presentation/user_contact_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context
        .read<ChatBloc>()
        .add(GetAviableContactsEvent(userId: _auth.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatFailure) {
            return Center(child: Text(state.message));
          } else if (state is ContactsLoaded) {
            List<Map<String, dynamic>> contacts = state.contacts;
            return SafeArea(
              child: Column(
                children: [
                  Text(
                    AppTextConstants.chatsText,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        separatorBuilder: (context, index) =>
                            const SizedBox.shrink(),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final currentContact = contacts[index];
                          return UserContactWidget(user: currentContact);
                        }),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
