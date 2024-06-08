import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';

class UserInputWidget extends StatelessWidget {
  final TextEditingController userController;
  final String reciverId;
  const UserInputWidget({
    super.key,
    required this.userController,
    required this.reciverId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: userController,
            decoration: const InputDecoration(hintText: 'input a message'),
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<ChatBloc>().add(SendMessageEvent(
                  message: userController.text,
                  reciverId: reciverId,
                ));
            userController.clear();
          },
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
