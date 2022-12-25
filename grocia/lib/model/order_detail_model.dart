import 'package:grocia/model/address_model.dart';
import 'package:grocia/model/cart_item_model.dart';

enum Status { Delivered, Canceled, PaymentFailed, InProgress }

class OrderDetailModel {
  final String userId;
  final String orderId;
  final String invoiceNo;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final AddressModel deliveryAddress;
  final List<CartItemModel> items;
  final Status orderStatus;

  double get totalCost {
    return items.fold<double>(
        0, (previousValue, element) => previousValue + element.itemCost);
  }

  OrderDetailModel(
      {required this.userId,
      required this.orderId,
      required this.invoiceNo,
      required this.orderDate,
      required this.deliveryDate,
      required this.deliveryAddress,
      required this.orderStatus,
      required this.items});
}

final dummyOrderAddress = AddressModel(
    Address: "test",
    ZipCode: "test",
    City: "test",
    Country: "test",
    UserName: "test",
    UserPhone: "test",
    UserEmail: "test",
    addressType: AddressType.Home);
final dummyCartItems = [
  CartItemModel(
      itemName: "Bread", itemCost: 12.5, quantity: 1, itemImage: "g2.png", offer: 10),
  CartItemModel(
      itemName: "Spinach",
      itemCost: 12.5,
      quantity: 1,
      itemImage: "g2.png",
      offer: 0),
  CartItemModel(
      itemName: "Chilli", itemCost: 12.5, quantity: 1, itemImage: "g2.png", offer: 0),
];
final dummyOrderList = [
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "1",
      invoiceNo: "12",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.Delivered,
      items: dummyCartItems),
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "2",
      invoiceNo: "13",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.Delivered,
      items: dummyCartItems),
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "3",
      invoiceNo: "14",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.InProgress,
      items: dummyCartItems),
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "4",
      invoiceNo: "15",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.InProgress,
      items: dummyCartItems),
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "5",
      invoiceNo: "16",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.Canceled,
      items: dummyCartItems),
  OrderDetailModel(
      userId: "qweqweqwe",
      orderId: "6",
      invoiceNo: "17",
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: dummyOrderAddress,
      orderStatus: Status.PaymentFailed,
      items: dummyCartItems)
];
