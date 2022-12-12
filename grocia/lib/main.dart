import 'package:flutter/material.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/provider/cart_detail.provider.dart';
import 'package:grocia/provider/order_detail_provider.dart';
import 'package:grocia/screen/account_edit_screen.dart';
import 'package:grocia/screen/account_info_screen.dart';
import 'package:grocia/screen/account_screen.dart';
import 'package:grocia/screen/cart_screen.dart';
import 'package:grocia/screen/home_screen.dart';
import 'package:grocia/screen/order_detail_screen.dart';
import 'package:grocia/screen/order_screen.dart';
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
          create: (context) => AuthProvider(dummyUser),
        ),
        ChangeNotifierProvider<OrderDetailProvider>(
          create: (context) => OrderDetailProvider(dummyOrderList),
        ),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(dummyCartItems))
      ],
      child: MaterialApp.router(
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) => RouteMap(
              onUnknownRoute: (_) => const Redirect(HomeScreen.routeName),
              routes: {
                HomeScreen.routeName: (routeData) =>
                    const MaterialPage(child: HomeScreen()),
                CartScreen.routeName: (routeData) =>
                    const MaterialPage(child: CartScreen()),
                OrderScreen.routeName: (routeData) =>
                    const MaterialPage(child: OrderScreen()),
                "${OrderScreen.routeName}/:id": (routeData) => MaterialPage(
                    child: OrderDetailScreen(
                        OrderId: routeData.pathParameters['id'] ?? '')),
                AccountScreen.routeName: (routeData) =>
                    const MaterialPage(child: AccountScreen()),
                "${AccountScreen.routeName}/edit": (RouteData) =>
                    const MaterialPage(child: AccountEditScreen()),
                "${AccountScreen.routeName}/:info": (routeData) => MaterialPage(
                    child: AccountInfoScreen(
                        infoType: routeData.pathParameters['info'] ?? ''))
              }),
        ),
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
