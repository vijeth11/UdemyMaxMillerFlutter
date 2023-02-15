import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class OrderSuccessPage extends StatelessWidget {
  final String username;
  final VoidCallback onClick;
  const OrderSuccessPage(
      {Key? key, required this.username, required this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 25, right: 25, bottom: 20),
      width: double.infinity,
      height: double.infinity,
      color: kGreenColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // username and message container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: kYellowColor,
                  size: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${username}, Your order has been successful",
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kWhiteColor,
                    fontSize: 25,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "🎉",
                  style:
                      TextStyle(fontSize: 35, decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15),
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
          // button container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kWhiteColor,
            ),
            child: Column(
              children: [
                const Text(
                  "Preparing your order",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.none,
                      color: kBlackColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Your order will be prepared and will come soon",
                  style: TextStyle(
                      color: kGreyColor,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(kBlackColor),
                        backgroundColor:
                            MaterialStateProperty.all(kYellowColor),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(50))),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onClick();
                    },
                    child: const Text("Track my Order"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
