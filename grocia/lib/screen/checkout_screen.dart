import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocia/widgets/back-button-appBar.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = "/checkout";
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackActionAppBar(context, "Checkout Page"),
      body: Center(child: Text("checkout page"),),
    );
  }
}
