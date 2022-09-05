import 'package:flutter/material.dart';

class PaymentInfoForm extends StatefulWidget {
  final Function getTextInput;
  final VoidCallback onPress;
  const PaymentInfoForm({Key? key, required this.getTextInput, required this.onPress})
      : super(key: key);

  @override
  State<PaymentInfoForm> createState() => _PaymentInfoFormState();
}

class _PaymentInfoFormState extends State<PaymentInfoForm>
    with SingleTickerProviderStateMixin {
  late bool displayingCOD;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _codOffsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  late final Animation<Offset> _paymentOffsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    displayingCOD = false;
    Future.delayed(const Duration(seconds: 0))
        .then((value) => _controller.forward());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getTabButtons("COD", () {
              setState(() {
                displayingCOD = true;
              });
              _controller.reset();
              _controller.forward();
            }, displayingCOD,
                const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
            getTabButtons("Credit Card", () {
              setState(() {
                displayingCOD = false;
                _controller.reset();
                _controller.forward();
              });
            }, !displayingCOD,
                const EdgeInsets.symmetric(vertical: 20, horizontal: 40))
          ],
        ),
        if (displayingCOD) getCODdetails(),
        if (!displayingCOD) getCardPaymentDetails(),
      ],
    );
  }

  Widget getTabButtons(String name, VoidCallback onPress, bool displayingCOD,
      EdgeInsets padding) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                displayingCOD ? Colors.green.shade500 : Colors.white),
            foregroundColor: MaterialStateProperty.all(
                displayingCOD ? Colors.white : Colors.black),
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.green.shade500, width: 2)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            padding: MaterialStateProperty.all(padding)),
        onPressed: onPress,
        child: Text(
          name,
          style: const TextStyle(fontSize: 20),
        ));
  }

  Widget getCODdetails() {
    return SlideTransition(
        position: _codOffsetAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: widget.onPress,
              child: const Text("BUY"),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade500),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  alignment: Alignment.center,
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 60))),
            ),
          ],
        ));
  }

  Widget getCardPaymentDetails() {
    return SlideTransition(
        position: _paymentOffsetAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/card.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.only(top: 40, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Credit Card",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "\$XXXXX",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text("**** **** **** 1234",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Card Holder Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Card Number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Month/Year",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 155, child: widget.getTextInput()),
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CVV",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 155, child: widget.getTextInput()),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Country",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: widget.onPress,
              child: const Text("BUY"),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade500),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  alignment: Alignment.center,
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 60))),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
