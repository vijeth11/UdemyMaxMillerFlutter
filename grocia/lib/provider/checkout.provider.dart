import 'package:flutter/cupertino.dart';
import 'package:grocia/model/checkout_model.dart';

class CheckoutProvider extends ChangeNotifier {
  final CheckOutModel _item;

  CheckoutProvider(this._item);
  
  CheckOutModel get item{
    return _item;
  }
}
