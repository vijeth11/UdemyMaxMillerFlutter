import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './providers/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Lato',
        // this is a customized page change animation which overrides material theme
        // page animation and uses the animation defined in the builder class which in
        // current case is Fade in animation (go to helpers folder)
        // For different animations for different pages look at main_drawer file.
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder()
        }));

    // this is how we instantiate a state management by wrapping the Material app with
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
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProduct) => Products(
              auth.token ?? "",
              auth.userId,
              previousProduct != null ? previousProduct.items : []),
          create: (ctx) => Products("", "", []),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders("", ""),
          update: (ctx, auth, order) => Orders(auth.token ?? "", auth.userId),
        ),
      ],
      // this is done so that app can auto authenticate user based on token and
      // direct him to products view screen rather than showing the login screen
      // all the time when user opens the app.
      // Here we only want to relad the home screen based on the auth provider
      // hence we are wrapping the material app with consumer so we can access the
      // auth cheange screen acordingly
      child: Consumer<Auth>(builder: (ctx, auth, child) {
        print("is the material app authenticated ${auth.isAuth}");
        return MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
              colorScheme:
                  theme.colorScheme.copyWith(secondary: Colors.deepOrange)),
          home: auth.isAuth
              ? ProductsOverViewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            //ProductsOverViewScreen.routeName: (ctx) => ProductsOverViewScreen(),
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductScreen.routeName: (ctx) => const UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen()
          },
        );
      }),
    );
  }
}
