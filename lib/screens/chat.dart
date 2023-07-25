import 'package:chatty/chat_messages.dart';
import 'package:chatty/new_message.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Chatty',
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
