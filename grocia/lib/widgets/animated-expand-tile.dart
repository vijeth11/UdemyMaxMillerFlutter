import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class AnimatedExpandTile extends StatelessWidget {
  final int tileExpandDuration;
  final int tileCollapseDuration;
  final bool isExpanded;
  final double tileExpandedHeight;
  final double tileCollapsedHeight;
  final Widget titleHeading;
  final double contentHeight;
  final Widget content;
  final VoidCallback onClick;
  const AnimatedExpandTile(
      {super.key,
      required this.titleHeading,
      required this.contentHeight,
      required this.content,
      required this.onClick,
      required this.tileExpandDuration,
      required this.tileCollapseDuration,
      required this.isExpanded,
      required this.tileExpandedHeight,
      required this.tileCollapsedHeight});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
          milliseconds: isExpanded ? tileCollapseDuration : tileExpandDuration),
      height: isExpanded ? tileExpandedHeight : tileCollapsedHeight,
      curve: Curves.easeIn,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          decoration: const BoxDecoration(
              color: kWhiteColor,
              border: Border(bottom: BorderSide(color: kGreyLightColor))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: titleHeading,
                ),
                AnimatedContainer(
                  duration: Duration(
                      milliseconds: isExpanded
                          ? tileExpandDuration
                          : tileCollapseDuration),
                  height: isExpanded ? contentHeight : 0,
                  child: content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
