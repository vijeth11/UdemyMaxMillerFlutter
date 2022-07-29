import 'package:flutter/cupertino.dart';

class PlayerData {
  final score = ValueNotifier<int>(0);
  final health = ValueNotifier<int>(5);
}
