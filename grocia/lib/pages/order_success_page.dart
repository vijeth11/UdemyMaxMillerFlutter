import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class OrderSuccessPage extends StatelessWidget {
  final String username;
  const OrderSuccessPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: kGreenColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: kOrangeColor,
                ),
                Text(
                  "${username}, Your order has been successful",
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                const Text(
                  "🎉",
                  style: TextStyle(fontSize: 30),
                ),
                RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                  TextSpan(text: "Check your order status in "),
                  TextSpan(
                      text: "My Order",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " about next steps information.")
                ]))
              ],
            ),
          ),
          Container(
            color: kWhiteColor, 
            child: Column(children: [],),
          )
        ],
      ),
    );
  }
}
