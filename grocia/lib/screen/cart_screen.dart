import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/cart_item_model.dart';
import 'package:grocia/provider/cart_detail.provider.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:grocia/widgets/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  static const int iconIndex = 1;
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // TODO: open a drawer on click of menu
              },
              icon: const Icon(
                Icons.menu,
                color: kBlackColor,
              ))
        ],
        foregroundColor: kBlackColor,
        backgroundColor: kGreyLightColor,
        elevation: 0.0,
        title: const Text(
          "Cart",
          style: screenHeaderStyle,
        ),
      ),
      // consumer builds only required part
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final items = cartProvider.items;
          return Stack(children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                CartItemModel cartItem = items[index];
                return CartTile(cartItem: cartItem);
              },
            ),
            // Subtotal Button
            getSubTotalButton(context, cartProvider)
          ]);
        },
      ),
      bottomNavigationBar: const BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }

  Positioned getSubTotalButton(
      BuildContext context, CartProvider cartProvider) {
    return Positioned(
      bottom: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        margin: EdgeInsets.symmetric(
            vertical: 25, horizontal: MediaQuery.of(context).size.width * 0.05),
        decoration: buttonStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subtotal Rs${cartProvider.subTotalCost}",
                  style: screenHeaderStyle.copyWith(color: kWhiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Proceed to checkout",
                  style: TextStyle(color: kWhiteColor),
                )
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: kWhiteColor,
            )
          ],
        ),
      ),
    );
  }
}
