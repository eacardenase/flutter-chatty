import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No messages found.',
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Something went wrong.',
            ),
          );
        }

        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) {
            final currentMessage = loadedMessages[index].data()['text'];

            return Text(currentMessage);
          },
        );
      },
    );
  }
}
