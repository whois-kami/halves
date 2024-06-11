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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              controller: userController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                filled: true,
                fillColor: const Color(0xFF565556),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _onPressed(context);
              userController.clear();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  void _onPressed(BuildContext context) {
    context.read<ChatBloc>().add(SendMessageEvent(
          message: userController.text,
          reciverId: reciverId,
        ));
    userController.clear();
  }
}
