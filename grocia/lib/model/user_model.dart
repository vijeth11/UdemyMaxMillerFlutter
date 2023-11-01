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

  Map<String, Object> toMap() {
    return {
      userId:{
        "displayName":displayName,
        "profileImage":profileImage,
        "email":userEmail,
        "phoneNumber":phoneNumber,
        "addresses":addresses.map((e) => e.toMap()).toList()
      }
    };
  }

  UserModel copyTo(
      {String? displayName,
      String? userId,
      String? phoneNumber,
      String? userEmail,
      String? profileImage}) {
    return UserModel(
        userId: userId ?? this.userId,
        addresses: addresses,
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileImage: profileImage ?? this.profileImage,
        userEmail: userEmail ?? this.userEmail
        );
  }
}

final dummyAddress = AddressModel(
    Address: "test",
    ZipCode: "test",
    City: "test",
    Country: "test",
    UserName: "test",
    UserPhone: "test",
    UserEmail: "test",
    isDefault: true,
    addressType: AddressType.Home);

final dummyAddress1 = AddressModel(
    Address: "test1",
    ZipCode: "test1",
    City: "test1",
    Country: "test1",
    UserName: "test1",
    UserPhone: "test1",
    UserEmail: "test1",
    addressType: AddressType.Work);

final dummyUser = UserModel(
    displayName: "test user",
    userId: "qweqwe",
    profileImage: "assets/images/grocia-logo.png",
    userEmail: "test@test.com",
    phoneNumber: "(+91)9632876421",
    addresses: [dummyAddress, dummyAddress1]);
