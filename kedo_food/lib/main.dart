import 'package:flutter/material.dart';
import 'package:kedo_food/providers/auth_provider.dart';
import 'package:kedo_food/providers/cart_item_provider.dart';
import 'package:kedo_food/providers/order_items_provider.dart';
import 'package:kedo_food/providers/products.dart';
import 'package:kedo_food/screens/auth_screen.dart';
import 'package:kedo_food/screens/cart_checkout.dart';
import 'package:kedo_food/screens/cart_menu.dart';
import 'package:kedo_food/screens/category_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/item_detail.dart';
import 'package:kedo_food/screens/message_bot.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/screens/order_detail_screen.dart';
import 'package:kedo_food/screens/user_profile.dart';
import 'package:kedo_food/screens/user_profile_options.dart';
import 'package:kedo_food/screens/wish_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProxyProvider<Auth, OrderItemProvider>(
          create: (_) => OrderItemProvider('', ''),
          update: (_, auth, previousOrderItem) =>
              OrderItemProvider(auth.userId, auth.token ?? ''),
        ),
        ChangeNotifierProxyProvider<Products, CartItemProvider>(
            create: (_) => CartItemProvider([], [], true),
            update: (_, products, previousCartItem) => CartItemProvider(
                products.items,
                previousCartItem?.items ?? [],
                previousCartItem?.loadDataFromDatabase ?? true)),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Kedo Food',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
          home: auth.isAuth
              ? const MyHomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, state) {
                    if (state.connectionState == ConnectionState.waiting) {
                      // needs to be changed to splash screen or auto scroll
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AuthScreen(
                      onPress: (bool isSignIn, String email, String password,
                          {String username = ''}) async {
                        if (isSignIn) {
                          await auth.login(email, password);
                        } else {
                          await auth.signup(email, password, username);
                        }
                      },
                    );
                  }),
          routes: {
            //MyHomePage.routeName: (context) => MyHomePage(),
            CategoryTypeList.routeName: (context) => CategoryTypeList(),
            CategoryMenu.routeName: (context) => CategoryMenu(),
            ItemDetail.routeName: (context) => ItemDetail(),
            CartMenu.routeName: (context) => CartMenu(),
            WishList.routeName: (context) => const WishList(),
            UserProfileOption.routeName: (context) => UserProfileOption(),
            UserProfile.routeName: (context) => UserProfile(),
            MyOrders.routeName: (context) => MyOrders(),
            OrderDetailScreen.routeName: (context) => OrderDetailScreen(),
            MessageBot.routeName: (context) => const MessageBot(),
            CartCheckout.routeName: (context) => const CartCheckout()
          },
        ),
      ),
    );
  }
}
