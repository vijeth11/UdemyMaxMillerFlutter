import 'package:flutter/material.dart';
import 'package:kedo_food/model/cart_item.dart';
import 'package:kedo_food/providers/cart_item_provider.dart';
import 'package:kedo_food/screens/cart_checkout.dart';
import 'package:kedo_food/widgets/bottom_navigator.dart';
import 'package:provider/provider.dart';

class CartMenu extends StatefulWidget {
  static const String routeName = 'CartMenu';
  // List<CartItem> cartItems = [
  //   CartItem(
  //       categoryName: 'Fruit',
  //       itemName: 'Banana',
  //       quantity: 4,
  //       itemCost: 7.2,
  //       itemImage: 'avacado.png'),
  //   CartItem(
  //       categoryName: 'Vegetable',
  //       itemName: 'Broccoli',
  //       quantity: 3,
  //       itemCost: 6.3,
  //       itemImage: 'avacado.png'),
  //   CartItem(
  //       categoryName: 'Fruit',
  //       itemName: 'Grapes',
  //       quantity: 5,
  //       itemCost: 5.7,
  //       itemImage: 'avacado.png'),
  //   CartItem(
  //       categoryName: 'Mushroom',
  //       itemName: 'Oyster Mushroom',
  //       quantity: 4,
  //       itemCost: 2.7,
  //       itemImage: 'avacado.png')
  // ];
  CartMenu({Key? key}) : super(key: key);

  @override
  State<CartMenu> createState() => _CartMenuState();
}

class _CartMenuState extends State<CartMenu> {
  final double leftRightPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    var cartItemProvider = Provider.of<CartItemProvider>(context);
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
                    onPressed: cartItemProvider.items.length == 0
                        ? null
                        : () {
                            Navigator.of(context)
                                .pushNamed(CartCheckout.routeName);
                          },
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: cartItemProvider.items.length == 0
                              ? Colors.grey.shade700
                              : Colors.green.shade400,
                          fontSize: 20),
                    ))
              ],
            ),
          ),
          // list of the cart items
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: leftRightPadding, right: leftRightPadding),
              // Display circular loader for first time when app starts and feches data from
              // sqlite database
              child: cartItemProvider.loadDataFromDatabase
                  ? FutureBuilder(
                      future: cartItemProvider.fetchDataFromDatabase(),
                      builder: (ctx, state) {
                        cartItemProvider.loadDataFromDatabase = false;
                        return state.connectionState == ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : getCartItemList(cartItemProvider);
                      })
                  : getCartItemList(cartItemProvider),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigator(BottomIcons.Cart),
    );
  }

  Widget getCartItemList(CartItemProvider provider) {
    // returns a list of cart items with quantity and cost
    return provider.items.length > 0
        ? ListView.builder(
            // changing padding helps to add gap for top of the list
            padding: EdgeInsets.only(top: 30),
            itemCount: provider.items.length,
            itemBuilder: (context, index) =>
                getCartItem(provider.items[index], provider))
        : Center(
            child: Text("Please add some items"),
          );
  }

  Widget getCartItem(CartItem item, CartItemProvider provider) {
    // return a single cart tile with image, cost, quantity and increase or decrease button
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
                    image: NetworkImage(item.itemImage), fit: BoxFit.cover)),
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
                                  onPressed: () {
                                    provider.removeItemFromCart(item.itemId);
                                  },
                                  icon: const Icon(Icons.remove, size: 30)),
                              Text(
                                item.quantity.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    provider.addItemToCart(item.itemId);
                                  },
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
