import 'package:flutter/material.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user-products';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Your Products'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ],
    );

    return Scaffold(
        appBar: appBar,
        drawer: MainDrawer(
          appBarHeight: appBar.preferredSize.height,
        ),
        // If you are using Futurebuilder then make sure you do not have same provider listner with listen set to true
        // as a property of the class used in futurebuilder because it will cause an infinite loop every time futurebuilder
        // completes  calling a future and if it updates the class property provider then again build method will be called
        //  due to which again the FutureBuilder will be called and this turns into loop. So it is better to wrap the child
        // widget which requires the updated data with the consumer as done below.
        body: FutureBuilder(
          future: Provider.of<Products>(context, listen: false)
              .fetchAndSetProducts(true),
          builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return Provider.of<Products>(context, listen: false)
                            .fetchAndSetProducts(true);
                      },
                      child: Consumer<Products>(
                        builder: (context, productListner, child) => SafeArea(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              var product = productListner.items[index];
                              // you dont need to wrap ListTile widget with card you if error is thrown it
                              // can because of the intenal child widget of ListTile pls check first error message
                              return Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  elevation: 5,
                                  child: UserProductItem(
                                      id: product.id,
                                      title: product.title,
                                      imageUrl: product.imageUrl));
                            },
                            itemCount: productListner.items.length,
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
