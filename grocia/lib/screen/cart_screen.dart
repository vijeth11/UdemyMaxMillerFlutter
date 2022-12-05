import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/cart_item_model.dart';
import 'package:grocia/provider/cart_detail.provider.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  static const int iconIndex = 1;
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CartProvider>(context).items;
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          CartItemModel cartItem = items[index];
          return Row(
            children: [
              Stack(
                children: [
                  Image(
                    height: 80,
                    width: 80,
                      image: AssetImage("asstes/images/${cartItem.itemImage}")),
                  if (cartItem.offer > 0.0)
                    Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: kRedColor.withOpacity(0.4),
                          child: Text(
                            "${cartItem.offer}%",
                            style: TextStyle(color: kRedColor),
                          ),
                        ))
                ],
              ),
              Column(children: [
                Text(cartItem.itemName)
                
              ],)
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}
