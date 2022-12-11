import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/cart_item_model.dart';
import 'package:grocia/provider/cart_detail.provider.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartItemModel cartItem;
  const CartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Row(
      children: [
        // tile leading section
        getTitleLeadingWidget(cartItem),
        //Center Title section
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.63,
          child: getTitleCenterWidget(cartItem, cartProvider),
        ),
      ],
    );
  }

  Stack getTitleLeadingWidget(CartItemModel cartItem) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Image(
                height: 100,
                width: 100,
                image: AssetImage("assets/images/${cartItem.itemImage}"))),
        if (cartItem.offer > 0.0)
          Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kRedColor.withOpacity(0.19)),
                child: Text(
                  "${cartItem.offer}%",
                  style: const TextStyle(
                      color: kRedColor, fontWeight: FontWeight.w700),
                ),
              ))
      ],
    );
  }

  Column getTitleCenterWidget(
      CartItemModel cartItem, CartProvider cartProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.itemName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 7,
        ),
        cartItem.offer > 0.0
            ? Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Rs ${cartItem.itemCost}/Kg ',
                      style: const TextStyle(
                        color: kGreenColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text: ' ${cartItem.offerAmount}/Kg',
                    ),
                  ],
                ),
              )
            : Text('Rs ${cartItem.itemCost}'),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rs ${(cartItem.offer > 0 ? cartItem.offerAmount : cartItem.itemCost) * cartItem.quantity}",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            getCartItemQuantity(cartProvider, cartItem)
          ],
        )
      ],
    );
  }

  Row getCartItemQuantity(CartProvider cartProvider, CartItemModel cartItem) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              cartProvider.addItemToCart(cartItem);
            },
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), primary: kWhiteColor),
            child: const Icon(
              Icons.add,
              size: 15,
              color: kRedColor,
            )),
        Text("${cartItem.quantity}"),
        ElevatedButton(
            onPressed: () {
              cartProvider.removeItemFromCart(cartItem);
            },
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), primary: kWhiteColor),
            child: const Icon(
              Icons.remove,
              size: 15,
              color: kRedColor,
            )),
      ],
    );
  }
}
