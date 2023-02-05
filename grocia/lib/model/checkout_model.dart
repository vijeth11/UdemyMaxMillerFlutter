import 'package:grocia/model/address_model.dart';
import 'package:grocia/model/cart_item_model.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/model/payment_model.dart';
import 'package:grocia/model/user_model.dart';

class CheckOutModel {
  final AddressModel selectedAddress;
  final PaymentModel paymentDetails;
  final List<CartItemModel> cartItems;
  CheckOutModel(this.selectedAddress, this.paymentDetails, this.cartItems);

  double get totalCost {
    return cartItems.fold<double>(
        0, (previousValue, element) => previousValue + element.itemCost);
  }

}

 final dummyCheckoutMode = CheckOutModel(
    dummyAddress,
    PaymentModel(selectedPayment: PaymentMethod.Cash, isCashOnDelivery: true),
    dummyCartItems);
