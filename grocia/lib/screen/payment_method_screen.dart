import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/widgets/animated-expand-tile.dart';
import 'package:grocia/widgets/back-button-appBar.dart';

class PaymentMethodScreen extends StatefulWidget {
  static const String routeName = "/paymentMethod";
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool isExpaneded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackActionAppBar(context, "Payment Method"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Column(
          children: [
            AnimatedExpandTile(
                titleHeading: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card_rounded,
                          color: kGreenColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Credit/Debit Card",
                          style: TextStyle(color: kGreenColor),
                        )
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: kGreenColor,
                    )
                  ],
                ),
                contentHeight: 40,
                content: Text("Credit card"),
                onClick: () => setState(() {
                      isExpaneded = !isExpaneded;
                    }),
                tileExpandDuration: 420,
                tileCollapseDuration: 200,
                isExpanded: isExpaneded,
                tileExpandedHeight: 110,
                tileCollapsedHeight: 55)
          ],
        ),
      ),
      backgroundColor: kGreyLightColor,
    );
  }
}
