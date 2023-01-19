import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/screen/checkout_screen.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:routemaster/routemaster.dart';

enum PaymentMethod { Card, NetBanking, Cash }

class PaymentMethodScreen extends StatefulWidget {
  static const String routeName = "/paymentMethod";
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool isExpaneded = true;
  double screenWidth = 0.0;
  final spaceBetweenTwoInputs = 30.0;
  final divider = const SizedBox(
    height: 15,
  );
  PaymentMethod currentMethod = PaymentMethod.Card;
  final banks = ["HDFC", "ICICI", "AXIS", "SBI", "KOTAK"];
  String bankSelected = '';

  @override
  void initState() {
    this.bankSelected = banks[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width - spaceBetweenTwoInputs;
    return Scaffold(
        appBar: BackActionAppBar(context, "Payment Method"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            children: [
              getExpansionTile("Credit/Debit Card", Icons.credit_card_rounded,
                  [getCardExpandTileContent()], PaymentMethod.Card),
              const SizedBox(
                height: 20,
              ),
              getExpansionTile(
                  "Net Banking",
                  Icons.money_sharp,
                  [getNetbankingExpandedTitleContent()],
                  PaymentMethod.NetBanking),
              const SizedBox(
                height: 20,
              ),
              getExpansionTile("Cash on Delivery", Icons.currency_rupee,
                  [getCashExpandedTileContent()], PaymentMethod.Cash)
            ],
          ),
        ),
        backgroundColor: kGreyLightColor,
        bottomSheet: SaveChangesButton(
          onPress: () => Routemaster.of(context).push(
            CheckoutScreen.routeName,
          ),
          title: "Continue",
        ));
  }

  Widget getExpansionTile(String title, IconData leadingIcon,
      List<Widget> children, PaymentMethod method) {
    return ExpansionTile(
        key: new Key(new Random().nextInt(10000).toString()),
        title: Text(title),
        initiallyExpanded: currentMethod == method,
        backgroundColor: kWhiteColor,
        collapsedBackgroundColor: kWhiteColor,
        iconColor: kGreenColor,
        collapsedIconColor: kGreenColor,
        collapsedTextColor: kGreenColor,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
        textColor: kGreenColor,
        onExpansionChanged: (isExpanded) {
          if (isExpanded) {
            setState(() {
              currentMethod = method;
            });
          }
        },
        leading: Icon(
          leadingIcon,
          color: kGreenColor,
        ),
        children: children);
  }

  Widget getCardExpandTileContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Add new card",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(children: [
        const Text("WE ACCEPT "),
        const Text(
          "(Master Card/ Visa Card/ Rupay)",
          style: const TextStyle(fontWeight: FontWeight.w700),
        )
      ]),
      divider,
      divider,
      ...getInputForm("Card number", icon: Icons.credit_card_rounded),
      divider,
      Row(
        children: [
          SizedBox(
            width: screenWidth * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...getInputForm("Valid through(MM/YY)"),
              ],
            ),
          ),
          SizedBox(
            width: spaceBetweenTwoInputs,
          ),
          SizedBox(
              width: screenWidth * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...getInputForm("CVV")],
              )),
        ],
      ),
      divider,
      ...getInputForm("Name on card"),
      divider,
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(value: false, onChanged: (data) {}),
          const Text("Save this card for a faster checkout next time.")
        ],
      )
    ]);
  }

  Widget getNetbankingExpandedTitleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Netbanking Banks",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19)),
        divider,
        ...getInputForm("Bank Account Number"),
        divider,
        ...getInputForm("Bank IFSC Code"),
        divider,
        DropdownButtonFormField(
          items: banks
              .map((bank) => DropdownMenuItem<String>(
                    value: bank,
                    child: Text(
                      bank,
                    ),
                  ))
              .toList(),
          value: bankSelected,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              bankSelected = value as String;
            });
          },
          onSaved: (value) {
            // need to be implemented
          },
        ),
        divider
      ],
    );
  }

  Widget getCashExpandedTileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            const Text(
              "Cash",
              style: const TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 47.0),
          child: const Text(
            "Please keep exect change handy to help us serve you",
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
        divider
      ],
    );
  }
}
