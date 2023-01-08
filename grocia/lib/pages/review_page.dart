import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:intl/intl.dart';

enum ReviewType { Bad, Better, Good }

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
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Rate your order experience",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(DateFormat(
              "dd MMMM yyyy",
            ).format(widget.orderDate)),
            SizedBox(
              height: 10,
            ),
            Text("Give me what you feel after you finish your order"),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      backgroundColor: kGreyLightColor,
    );
  }

  SizedBox ReviewTypeSelector(double sizeOfButton, String title,
      ReviewType type, BorderRadius borderRadius) {
    return SizedBox(
      width: sizeOfButton,
      child: TextButton(
          onPressed: () {
            setState(() {
              selectedType = type;
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  selectedType == type ? kGreyColor : kWhiteColor),
              foregroundColor: MaterialStateProperty.all(
                  selectedType == type ? kWhiteColor : kGreyColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(color: kGreyColor),
                  borderRadius: borderRadius))),
          child: Text(title)),
    );
  }
}
