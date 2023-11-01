import 'package:flutter/material.dart';
import 'package:grocia/model/checkout_model.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/provider/cart_detail.provider.dart';
import 'package:grocia/provider/checkout.provider.dart';
import 'package:grocia/provider/order_detail_provider.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/screen/account_edit_screen.dart';
import 'package:grocia/screen/account_info_screen.dart';
import 'package:grocia/screen/account_screen.dart';
import 'package:grocia/screen/cart_screen.dart';
import 'package:grocia/screen/category_items_screen.dart';
import 'package:grocia/screen/checkout_screen.dart';
import 'package:grocia/screen/getting_started_screen.dart';
import 'package:grocia/screen/home_screen.dart';
import 'package:grocia/screen/landing_screen.dart';
import 'package:grocia/screen/order_detail_screen.dart';
import 'package:grocia/screen/order_screen.dart';
import 'package:grocia/screen/payment_method_screen.dart';
import 'package:grocia/screen/product_detail_screen.dart';
import 'package:grocia/screen/sign_in_screen.dart';
import 'package:grocia/screen/sign_up_screen.dart';
import 'package:grocia/screen/user_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<OrderDetailProvider>(
          create: (context) => OrderDetailProvider(dummyOrderList),
        ),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(dummyCartItems)),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider(dummyCheckoutMode)),
        ChangeNotifierProvider<ProductItemProvider>(
            create: (context) => ProductItemProvider(dummyItemModels))
      ],
      child: MaterialApp.router(
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) => RouteMap(
              onUnknownRoute: (_) => const Redirect(LandingScreen.routeName),
              routes: {
                LandingScreen.routeName: (route) =>
                    const MaterialPage(child: LandingScreen()),
                SignUpScreen.routeName: (route) =>
                    const MaterialPage(child: SignUpScreen()),
                SignInScreen.routeName: (route) =>
                    const MaterialPage(child: SignInScreen()),
                GettingStartedScreen.routeName: (route) =>
                    MaterialPage(child: GettingStartedScreen()),
                HomeScreen.routeName: (routeData) =>
                    MaterialPage(child: HomeScreen()),
                "${CategoryItemScreen.routeName}/:title": (routeData) =>
                    MaterialPage(
                        child: CategoryItemScreen(
                            routeData.pathParameters["title"] ?? '')),
                "${ProductDetailScreen.routeName}/:id": (routeData) =>
                    MaterialPage(
                        child: ProductDetailScreen(
                            itemId: int.parse(
                                routeData.pathParameters["id"] ?? '0'))),
                CartScreen.routeName: (routeData) =>
                    const MaterialPage(child: CartScreen()),
                PaymentMethodScreen.routeName: (route) =>
                    const MaterialPage(child: PaymentMethodScreen()),
                CheckoutScreen.routeName: (routeData) =>
                    const MaterialPage(child: CheckoutScreen()),
                OrderScreen.routeName: (routeData) =>
                    const MaterialPage(child: OrderScreen()),
                "${OrderScreen.routeName}/:id": (routeData) => MaterialPage(
                    child: OrderDetailScreen(
                        OrderId: routeData.pathParameters['id'] ?? '')),
                UserAddressScreen.routeName: (routeData) => MaterialPage(
                    child: UserAddressScreen(
                        displayContinueButton:
                            routeData.queryParameters["isCart"] == "1")),
                AccountScreen.routeName: (routeData) =>
                    const MaterialPage(child: AccountScreen()),
                "${AccountScreen.routeName}/edit": (routeData) =>
                    const MaterialPage(child: AccountEditScreen()),
                "${AccountScreen.routeName}/:info": (routeData) => MaterialPage(
                    child: AccountInfoScreen(
                        infoType: routeData.pathParameters['info'] ?? '')),
              }),
        ),
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }
}
