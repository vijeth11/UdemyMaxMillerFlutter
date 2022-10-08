import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kedo_food/helper/db_helper.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:kedo_food/providers/cart_item_provider.dart';
import 'package:kedo_food/providers/order_items_provider.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:kedo_food/widgets/payment_info_form.dart';
import 'package:kedo_food/widgets/shipping_address_form.dart';
import 'package:provider/provider.dart';

class CartCheckout extends StatefulWidget {
  static const String routeName = "checkout";
  const CartCheckout({Key? key}) : super(key: key);

  @override
  State<CartCheckout> createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  late bool isDisplayingShippingAddress;
  late bool shippingAddressCompleted;
  late OrderDetail orderDetail;
  late Future<OrderDetail> _loadingShippingAddress;

  ScrollController _controller = ScrollController();
  @override
  void initState() {
    isDisplayingShippingAddress = true;
    shippingAddressCompleted = false;
    _loadingShippingAddress = getInitialOrderDetail();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getPageHeader("Checkout", context, titlePladding: 65),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDisplayingShippingAddress = true;
                    shippingAddressCompleted = false;
                    _controller.jumpTo(0);
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: Colors.green.shade400, width: 5),
                      color: shippingAddressCompleted
                          ? Colors.green.shade400
                          : Colors.transparent),
                ),
              ),
              Container(
                width: 70,
                height: 3,
                color: shippingAddressCompleted
                    ? Colors.green.shade400
                    : Colors.grey.shade400,
              ),
              Container(
                width: 70,
                height: 3,
                color: Colors.grey.shade400,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: shippingAddressCompleted
                            ? Colors.green.shade400
                            : Colors.grey.shade400,
                        width: 5),
                    color: shippingAddressCompleted
                        ? Colors.white
                        : Colors.grey.shade400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Shipping Address",
                style: TextStyle(
                    color: shippingAddressCompleted
                        ? Colors.green.shade600
                        : Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "Payment Method",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: shippingAddressCompleted
                        ? Colors.black87
                        : Colors.grey.shade400),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: isDisplayingShippingAddress
                      ? FutureBuilder<OrderDetail>(
                          future: _loadingShippingAddress,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ShippingAddressForm(
                                getTextInput: getTextInput,
                                shippingData: snapshot.data!,
                                onPress: (OrderDetail detail,
                                    bool saveShippingAddress) async {
                                  if (saveShippingAddress) {
                                    await DBHelper.RemoveAll(
                                        'shipping_address');
                                    await DBHelper.insert('shipping_address', {
                                      'deliveryUserName':
                                          detail.deliveryUserName,
                                      'deliveryUserPhone':
                                          detail.deliveryUserPhone,
                                      'deliveryUserEmail':
                                          detail.deliveryUserEmail,
                                      'deliveryAddress': detail.deliveryAddress,
                                      'deliveryZipCode': detail.deliveryZipCode,
                                      'deliveryCity': detail.deliveryCity,
                                      'deliveryCountry': detail.deliveryCountry
                                    });
                                  } else {
                                    await DBHelper.RemoveAll(
                                        'shipping_address');
                                  }
                                  setState(() {
                                    shippingAddressCompleted = true;
                                    isDisplayingShippingAddress = false;
                                    orderDetail = detail;
                                    _controller.jumpTo(0);
                                  });
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                      : PaymentInfoForm(
                          getTextInput: getTextInput,
                          onPress: (Payment payment) {
                            // set the invoiceId, orderId, payment, cart items
                            // send it to server and updated provider
                            var cartItemProvider =
                                Provider.of<CartItemProvider>(context,
                                    listen: false);
                            orderDetail = orderDetail.copyWith(
                                orderPayement: payment,
                                orderId: getRandomString(10),
                                invoiceNo: getRandomString(10),
                                orderItems: [...cartItemProvider.items]);
                            print(orderDetail);
                            cartItemProvider.removeAll();
                            Provider.of<OrderItemProvider>(context,
                                    listen: false)
                                .addOrderDetails(orderDetail)
                                .then((value) => Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                        MyOrders.routeName,
                                        (route) =>
                                            route.settings.name ==
                                            MyHomePage.routeName));
                          },
                        )),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextInput(
      {int maxLines = 1,
      FocusNode? node,
      TextInputAction? inputAction,
      TextInputType? inputType,
      String? initialValue,
      Function(String?)? onSaved,
      String? Function(String?)? validate,
      String? placeholderText,
      List<TextInputFormatter>? textFormatter}) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: inputAction,
      keyboardType: inputType,
      focusNode: node,
      onSaved: onSaved,
      maxLines: maxLines,
      validator: validate,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      inputFormatters: textFormatter,      
      decoration: InputDecoration(
        hintText: placeholderText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  Future<OrderDetail> getInitialOrderDetail() async {
    var data = (await DBHelper.getData('shipping_address'));
    return OrderDetail(
        userId: '',
        orderId: '',
        invoiceNo: '',
        orderDate: DateTime.now(),
        orderPayement: Payment.Cash,
        orderStatus: Status.InProgress,
        orderItems: [],
        deliveryDate: DateTime.now().add(Duration(days: 3)),
        deliveryAddress:
            data.length > 0 ? data.first['deliveryAddress'] as String : '',
        deliveryCity:
            data.length > 0 ? data.first['deliveryCity'] as String : '',
        deliveryCountry:
            data.length > 0 ? data.first['deliveryCountry'] as String : '',
        deliveryZipCode:
            data.length > 0 ? data.first['deliveryZipCode'] as String : '',
        deliveryUserName:
            data.length > 0 ? data.first['deliveryUserName'] as String : '',
        deliveryUserPhone:
            data.length > 0 ? data.first['deliveryUserPhone'] as String : '',
        deliveryUserEmail:
            data.length > 0 ? data.first['deliveryUserEmail'] as String : '');
  }
}
