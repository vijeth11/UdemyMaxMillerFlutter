import 'package:flutter/material.dart';
import 'package:grocia/constants/checkout-screen.const.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/pages/order_success_page.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/provider/checkout.provider.dart';
import 'package:grocia/widgets/address-info-card.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/create_animated_router.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = "/checkout";
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutModel =
        Provider.of<CheckoutProvider>(context, listen: false).item;
    final userModel = Provider.of<AuthProvider>(context, listen: false).item;
    final selectedAddress = checkoutModel.selectedAddress;
    const totalStyle = TextStyle(
        fontSize: 22, color: kBlackColor, fontWeight: FontWeight.w700);
    return Scaffold(
      appBar: BackActionAppBar(context, "Checkout"),
      backgroundColor: kGreyLightColor,
      body: Column(
        children: [
          // Address Section
          getTitleSection(
              "Address",
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.location_on,
                  color: kGreenColor,
                ),
                label: const Text(
                  "change",
                  style: TextStyle(color: kGreenColor, fontSize: 19),
                ),
              )),
          getBodySection(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressInfoCard.getAddressInfoTitle(
                  selectedAddress.addressType.name, selectedAddress.isDefault),
              const SizedBox(
                height: 20,
              ),
              AddressInfoCard.getAddressInfoAddress(selectedAddress.toString())
            ],
          )),
          // Payment Section
          getTitleSection(
              "Payment",
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kGreenColor,
                  ))),
          getBodySection(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(checkoutModel.paymentDetails.selectedPayment.name)],
          )),
          // Cost Section
          getTitleSection("Total", null),
          getBodySection(Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Item Total"),
                  Text("Rs ${checkoutModel.totalCost}")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("Delivery Fee"), const Text("Rs 80")],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Cost"),
                  Text("Rs ${checkoutModel.totalCost + 80}")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 15, color: kBlackColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TO PAY",
                      style: totalStyle,
                    ),
                    Text(
                      "Rs ${checkoutModel.totalCost + 80}",
                      style: totalStyle,
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
      bottomSheet: SaveChangesButton(
          title: "Place Order",
          onPress: () {
            Navigator.of(context).push(
                CreateRoute(OrderSuccessPage(username: userModel.displayName)));
          }),
    );
  }

  Widget getTitleSection(String title, Widget? extraWidget) {
    return Container(
        padding: SectionPadding.copyWith(top: 8, bottom: 8),
        color: kWhiteColor,
        child: Row(
          mainAxisAlignment: extraWidget != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: kBlackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            if (extraWidget != null) extraWidget
          ],
        ));
  }

  Widget getBodySection(Widget child) {
    return Container(
      padding: SectionPadding,
      color: kGreyLightColor,
      width: double.infinity,
      child: child,
    );
  }
}
