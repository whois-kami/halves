import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:halves/features/messaging/presentation/message_field.dart';
import 'package:halves/features/messaging/presentation/user_input.dart';

class MsgScreen extends StatefulWidget {
  final String otherUID;
  final String otherName;
  const MsgScreen({
    super.key,
    required this.otherUID,
    required this.otherName,
  });

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  final TextEditingController userInputController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    context.read<ChatBloc>().add(
          GetChatMessagesEvent(
            userId: currentUser,
            otherId: widget.otherUID,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Chat with ${widget.otherName}'),
        leading: IconButton(
          onPressed: () => context.go('/chats'),
          icon: const Icon(Icons.chevron_left_outlined),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return StreamBuilder(
                    stream: state.messagesStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Text(AppTextConstants.messagingNoMessagesText));
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((doc) => MessageFieldWidget(doc: doc))
                              .toList(),
                        );
                      }
                    },
                  );
                } else if (state is ChatFailure) {
                  return Center(
                      child: Text('Failed to load messages: ${state.message}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          UserInputWidget(
            userController: userInputController,
            reciverId: widget.otherUID,
          ),
        ],
      ),
    );
  }
}
