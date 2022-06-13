import 'package:flutter/material.dart';
import 'package:my_shop/screens/order_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato');
    // this is how we instantiate a state management by wripping the Material app with
    // a provider class 'ChangeNotifierProvider'. This requires child attribute and
    // create attribute. create attribute takes a function which returns
    // an instance of the State class which has mixin ChangeNotifier with it
    // this same class needs to be used in the places where listeners are added
    // no other class will work. example can be seen in ProductsGrid class
    // We should use normal provider with create builder
    // if the data we are observing gets new set of values added to it and
    // we use provider.value constructor only if the value gets updated but not initialized again
    // this is best practice to avoid bugs
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.deepOrange)),
        home: ProductsOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: const Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
