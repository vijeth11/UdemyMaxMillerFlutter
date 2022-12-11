import 'package:grocia/model/address_model.dart';

class UserModel {
  final String displayName;
  final String userId;
  final String profileImage;
  final String userEmail;
  final String phoneNumber;
  final List<AddressModel> addresses;

  UserModel(
      {required this.displayName,
      required this.userId,
      required this.profileImage,
      required this.userEmail,
      required this.phoneNumber,
      required this.addresses});
}

final dummyAddress = AddressModel(
    Address: "test",
    ZipCode: "test",
    City: "test",
    Country: "test",
    UserName: "test",
    UserPhone: "test",
    UserEmail: "test");

final dummyUser = UserModel(
    displayName: "test user",
    userId: "qweqwe",
    profileImage: "assets/images/grocia-logo.png",
    userEmail: "test@test.com",
    phoneNumber: "(+91)9632876421",
    addresses: [
      dummyAddress
    ]);
