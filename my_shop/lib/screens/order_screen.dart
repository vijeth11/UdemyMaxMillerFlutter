import 'package:flutter/material.dart';
import 'package:my_shop/widgets/display_error.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' as Order;
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        body: RefreshIndicator(
            onRefresh: () => Provider.of<Order.Orders>(context, listen: false)
                .fetchAllOrders(),
            // this FutureBuilder takes a future object and a builder which gets the snapShot of the data and
            // based on that snapShot we can display the content. This helps when we do not want to convert
            // statelessWidget to statefullWidget just to display a loading symbol which is dependent on a future
            // Here we can also see usecase of the Consumer as we do not want to call the build method again
            // and agin which intern calls the fetch method to retrieve data from server everytime an orderdata is
            // changed so instead of having a provider we wrap the child which requires to listen the change in orderdata
            // with consumer in this case it is ListView.builder
            child: FutureBuilder(
              future: Provider.of<Order.Orders>(context, listen: false)
                  .fetchAllOrders(),
              builder: (ctx, dataSnapShot) {
                if (dataSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapShot.error != null) {
                    displayError(dataSnapShot.error, context, () {});
                    return const Center(
                      child: Text('Error Occurred'),
                    );
                  } else {
                    return Consumer<Order.Orders>(
                        builder: (context, orderData, child) =>
                            ListView.builder(
                              itemBuilder: (ctx, index) {
                                return OrderItem(
                                    order: orderData.orders[index]);
                              },
                              itemCount: orderData.orders.length,
                            ));
                  }
                }
              },
            )));
  }
}
