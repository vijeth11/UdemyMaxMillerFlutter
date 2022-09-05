import 'package:flutter/material.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:kedo_food/widgets/payment_info_form.dart';
import 'package:kedo_food/widgets/shipping_address_form.dart';

class CartCheckout extends StatefulWidget {
  static const String routeName = "checkout";
  const CartCheckout({Key? key}) : super(key: key);

  @override
  State<CartCheckout> createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  late bool isDisplayingShippingAddress;
  late bool shippingAddressCompleted;

  ScrollController _controller = ScrollController();
  @override
  void initState() {
    isDisplayingShippingAddress = true;
    shippingAddressCompleted = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getPageHeader("Checkout", context, titlePladding: 65),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDisplayingShippingAddress = true;
                    shippingAddressCompleted = false;
                    _controller.jumpTo(0);
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: Colors.green.shade400, width: 5),
                      color: shippingAddressCompleted
                          ? Colors.green.shade400
                          : Colors.transparent),
                ),
              ),
              Container(
                width: 70,
                height: 3,
                color: shippingAddressCompleted
                    ? Colors.green.shade400
                    : Colors.grey.shade400,
              ),
              Container(
                width: 70,
                height: 3,
                color: Colors.grey.shade400,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: shippingAddressCompleted
                            ? Colors.green.shade400
                            : Colors.grey.shade400,
                        width: 5),
                    color: shippingAddressCompleted
                        ? Colors.white
                        : Colors.grey.shade400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Shipping Address",
                style: TextStyle(
                    color: shippingAddressCompleted
                        ? Colors.green.shade600
                        : Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "Payment Method",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: shippingAddressCompleted
                        ? Colors.black87
                        : Colors.grey.shade400),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: isDisplayingShippingAddress
                      ? ShippingAddressForm(
                          getTextInput: getTextInput,
                          onPress: () {
                            setState(() {
                              shippingAddressCompleted = true;
                              isDisplayingShippingAddress = false;
                              _controller.jumpTo(0);
                            });
                          },
                        )
                      : PaymentInfoForm(
                          getTextInput: getTextInput,
                          onPress: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyOrders.routeName,
                                (route) =>
                                    route.settings.name ==
                                    MyHomePage.routeName);
                          },
                        )),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextInput({int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
