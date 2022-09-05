import 'package:flutter/material.dart';
import 'package:kedo_food/model/cart_item.dart';
import 'package:kedo_food/screens/cart_checkout.dart';
import 'package:kedo_food/widgets/bottom_navigator.dart';

class CartMenu extends StatefulWidget {
  static const String routeName = 'CartMenu';
  List<CartItem> cartItems = [
    CartItem(
        categoryName: 'Fruit',
        itemName: 'Banana',
        quantity: 4,
        itemCost: 7.2,
        itemImage: 'item-brocoli.png'),
    CartItem(
        categoryName: 'Vegetable',
        itemName: 'Broccoli',
        quantity: 3,
        itemCost: 6.3,
        itemImage: 'item-brocoli.png'),
    CartItem(
        categoryName: 'Fruit',
        itemName: 'Grapes',
        quantity: 5,
        itemCost: 5.7,
        itemImage: 'item-brocoli.png'),
    CartItem(
        categoryName: 'Mushroom',
        itemName: 'Oyster Mushroom',
        quantity: 4,
        itemCost: 2.7,
        itemImage: 'item-brocoli.png')
  ];
  CartMenu({Key? key}) : super(key: key);

  @override
  State<CartMenu> createState() => _CartMenuState();
}

class _CartMenuState extends State<CartMenu> {
  final double leftRightPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: leftRightPadding, right: leftRightPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shopping Cart',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartCheckout.routeName);
                    },
                    child: Text(
                      "Checkout",
                      style:
                          TextStyle(color: Colors.green.shade400, fontSize: 20),
                    ))
              ],
            ),
          ),
          // list of the cart items
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: leftRightPadding, right: leftRightPadding),
              child: ListView.builder(
                  // changing padding helps to add gap for top of the list
                  padding: EdgeInsets.only(top: 30),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    CartItem item =
                        widget.cartItems[index % widget.cartItems.length];
                    return getCartItem(item);
                  }),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigator(BottomIcons.Cart),
    );
  }

  Widget getCartItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(children: [
        // Image of the item with cost on left
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 120,
            height: 140,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${item.itemImage}'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 40,
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.green,
                child: Text(
                  "\$${item.itemCost}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        // Details of the Cart with category, name, quantity and total cost
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.categoryName.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    fontSize: 16),
              ),
              Text(
                item.itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${item.itemCost * item.quantity}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: 140,
                          height: 40,
                          color: Colors.grey.shade300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove, size: 30)),
                              const Text(
                                '4',
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add, size: 30))
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
