import 'package:kedo_food/helper/utils.dart';

final String botId = getRandomString(10);

class MessageDetails {
  final String message;
  final String fromId;
  final DateTime date;

  MessageDetails(
      {required this.message, required this.date, required this.fromId});
}
