import 'package:flutter/foundation.dart';
import 'package:grocia/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final UserModel _item;
  AuthProvider(this._item);

UserModel get item{
  return _item;
}

}
