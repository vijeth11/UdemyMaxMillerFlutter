import 'package:flutter/material.dart';
import 'package:kedo_food/widgets/page_header.dart';

class MessageBot extends StatefulWidget {
  static const String routeName = 'MessageBot';
  const MessageBot({Key? key}) : super(key: key);

  @override
  State<MessageBot> createState() => _MessageBotState();
}

class _MessageBotState extends State<MessageBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...getPageHeader("Message", context, titlePladding: 65),
        ],
      ),
    );
  }
}
