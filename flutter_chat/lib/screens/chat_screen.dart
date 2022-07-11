import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chats'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/GKHXiVADCLF8YyWtBQGx/messages')
            .snapshots(),
        builder: (ctx, streamSnapShot) {
          if (streamSnapShot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            final documents =
                (streamSnapShot.data as QuerySnapshot<Map<String, dynamic>>)
                    .docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(documents[index]['text']),
                    ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/GKHXiVADCLF8YyWtBQGx/messages')
              .add({'text': 'This was added by button'});
        },
      ),
    );
  }
}
