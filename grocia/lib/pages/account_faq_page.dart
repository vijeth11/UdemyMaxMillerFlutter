import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/widgets/animated-expand-tile.dart';

class AccountFAQPage extends StatefulWidget {
  const AccountFAQPage({super.key});

  @override
  State<AccountFAQPage> createState() => _AccountFAQPageState();
}

class _AccountFAQPageState extends State<AccountFAQPage> {
  final List<String> questions = [
    "Do you have any buil-in caching?",
    "Can i add/upgrade my plan at any time?",
    "What access comes with hosting plan?",
    "How do I change my password?"
  ];
  late int currentActiveIndex;

  @override
  void initState() {
    currentActiveIndex = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Basics",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return getQuestionTile(index);
          },
        ))
      ],
    );
  }

  Widget getQuestionTile(int index) {
    return AnimatedExpandTile(
      isExpanded: currentActiveIndex == index,
      tileExpandDuration: 420,
      tileCollapseDuration: 200,
      tileExpandedHeight: 100.0,
      tileCollapsedHeight: 50,
      titleHeading: Text(
        questions[index],
        style: const TextStyle(
            fontSize: 15, color: kBlackColor, fontWeight: FontWeight.w500),
      ),
      contentHeight: 40.0,
      content: const Text(
        "Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid ...",
        style: TextStyle(color: kGreyColor),
      ),
      onClick: () => setState(() {
        currentActiveIndex = currentActiveIndex == index ? -1 : index;
      }),
    );
  }
}
