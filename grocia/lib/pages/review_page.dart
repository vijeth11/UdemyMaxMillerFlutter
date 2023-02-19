import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  final DateTime orderDate;

  const ReviewPage({super.key, required this.orderDate});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  ReviewType selectedType = ReviewType.Good;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getPageAppBar("", context),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Rate your order experience",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(DateFormat(
              "dd MMMM yyyy",
            ).format(widget.orderDate)),
            const SizedBox(
              height: 30,
            ),
            const Text("Give me what you feel after you finish your order"),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReviewTypeSelector(
                    FaIcon(
                      FontAwesomeIcons.faceGrinHearts,
                      color: selectedType == ReviewType.Good
                          ? kWhiteColor
                          : kGreenColor,
                    ),
                    ReviewType.Good,
                    const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                ReviewTypeSelector(
                    FaIcon(
                      FontAwesomeIcons.faceSmile,
                      color: selectedType == ReviewType.Better
                          ? kWhiteColor
                          : kGreenColor,
                    ),
                    ReviewType.Better,
                    const BorderRadius.all(Radius.circular(0))),
                ReviewTypeSelector(
                    FaIcon(
                      FontAwesomeIcons.faceSadTear,
                      color: selectedType == ReviewType.Bad
                          ? kWhiteColor
                          : kGreenColor,
                    ),
                    ReviewType.Bad,
                    const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)))
              ],
            )
          ],
        ),
      ),
      backgroundColor: kGreyLightColor,
      bottomSheet: SaveChangesButton(onPress: () {}),
    );
  }

  TextButton ReviewTypeSelector(
      FaIcon icon, ReviewType type, BorderRadius borderRadius) {
    return TextButton(
        onPressed: () {
          setState(() {
            selectedType = type;
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                selectedType == type ? kGreenColor : kWhiteColor),
            foregroundColor: MaterialStateProperty.all(
                selectedType == type ? kWhiteColor : kGreenColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: const BorderSide(color: kGreenColor),
                borderRadius: borderRadius))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: icon,
        ));
  }
}
