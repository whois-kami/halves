import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';

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
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> current_contact = contacts[index];
                return InkWell(
                  onTap: () => context.go('/chatWith/${current_contact['id']}'),
                  child: ListTile(
                    title: Text(
                      current_contact['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(current_contact['sex']),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
