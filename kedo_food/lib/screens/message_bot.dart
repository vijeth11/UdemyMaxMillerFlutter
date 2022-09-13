import 'package:flutter/material.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/model/message_details.dart';
import 'package:kedo_food/widgets/page_header.dart';

class MessageBot extends StatefulWidget {
  static const String routeName = 'MessageBot';
  const MessageBot({Key? key}) : super(key: key);

  @override
  State<MessageBot> createState() => _MessageBotState();
}

class _MessageBotState extends State<MessageBot> {
  List<MessageDetails> messages = [
    MessageDetails(
        message: "Helloo", date: DateTime.now(), fromId: getRandomString(10)),
    MessageDetails(
        message: "Hi How can I help you", date: DateTime.now(), fromId: botId),
    MessageDetails(
        message: "Where Can I see my orders",
        date: DateTime.now(),
        fromId: getRandomString(10)),
    MessageDetails(
        message: "Please go to profile then you can option Orders",
        date: DateTime.now(),
        fromId: getRandomString(10)),
  ];
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...getPageHeader("Message", context, titlePladding: 65),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: SingleChildScrollView(
              child: Column(
                children: messages.map((e) {
                  if (e.fromId == botId) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth:
                                (MediaQuery.of(context).size.width / 2) + 25),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Text(
                          e.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxWidth:
                                    (MediaQuery.of(context).size.width / 2) +
                                        25),
                            decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Text(e.message,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    labelText: "Message",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2))),
                controller: controller,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
