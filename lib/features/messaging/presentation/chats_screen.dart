import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            return const CircularProgressIndicator();
          } else if (state is ChatFailure) {
            return Center(child: Text(state.message));
          } else if (state is ContactsLoaded) {
            List<Map<String, dynamic>> contacts = state.contacts;
            return SafeArea(
              child: Column(
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        separatorBuilder: (context, index) => const Divider(),
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
