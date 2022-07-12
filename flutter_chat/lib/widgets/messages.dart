import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            final messages =
                (snapshot.data as QuerySnapshot<Map<String, dynamic>>).docs;
            print(messages);
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index]['text'],
                  userId: messages[index]['userId'],
                  loggedInUser: FirebaseAuth.instance.currentUser!.uid,
                  userName: messages[index]['userName'],
                  userImage: messages[index]['userImage'],
                  key: ValueKey(messages[index].id),
                );
              },
              reverse: true,
            );
          }
        });
  }
}
