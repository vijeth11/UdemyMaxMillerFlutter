import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userId;
  final String loggedInUser;
  final String userName;
  final String userImage;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.userId,
    required this.loggedInUser,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: userId == loggedInUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: userId == loggedInUser
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: userId != loggedInUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: userId == loggedInUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12)),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                  crossAxisAlignment: userId == loggedInUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: userId == loggedInUser
                              ? Colors.black
                              : Colors.white),
                    ),
                    Text(message,
                        textAlign: userId == loggedInUser
                            ? TextAlign.end
                            : TextAlign.start,
                        style: TextStyle(
                          color: userId == loggedInUser
                              ? Colors.black
                              : Colors.white,
                        )),
                  ]),
            )
          ],
        ),
        Positioned(
            top: -10,
            left: userId == loggedInUser ? null : 120,
            right: userId == loggedInUser ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ))
      ],
    );
  }
}
