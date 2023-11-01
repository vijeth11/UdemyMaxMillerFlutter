enum AddressType { Home, Work, Other }

class AddressModel {
  final String Address;
  final String ZipCode;
  final String City;
  final String Country;
  final String UserName;
  final String UserPhone;
  final String UserEmail;
  final bool isDefault;
  final AddressType addressType;

  AddressModel(
      {required this.Address,
      required this.ZipCode,
      required this.City,
      required this.Country,
      required this.UserName,
      required this.UserPhone,
      required this.UserEmail,
      required this.addressType,
      this.isDefault = false});
  @override
  String toString() {
    return "$Address, $City, $Country $ZipCode";
  }

  Map<String, Object> toMap() {
    return {
      "address": Address,
      "ZipCode": ZipCode,
      "City": City,
      "Country": Country,
      "UserName": UserName,
      "UserPhone": UserPhone,
      "UserEmail": UserEmail,
      'isDefault': isDefault,
      'addressType': addressType
    };
  }
}
