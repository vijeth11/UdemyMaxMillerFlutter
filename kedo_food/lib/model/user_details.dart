class UserDetails {
  final String firstName;
  final String lastName;
  final String userName;
  final String userId;
  final String phone;
  final String emailAddress;
  final String shippingAddress;
  final String image;

  UserDetails(this.firstName, this.lastName, this.userName, this.phone,
      this.emailAddress, this.shippingAddress, this.image, this.userId);

  String get fullName {
    return "$firstName $lastName";
  }

  UserDetails copyTo(
      {String? firstName,
      String? lastName,
      String? userName,
      String? phone,
      String? emailAddress,
      String? shippingAddress,
      String? image,
      String? userId}) {
    return UserDetails(
        firstName ?? this.firstName,
        lastName ?? this.lastName,
        userName ?? this.userName,
        phone ?? this.phone,
        emailAddress ?? this.emailAddress,
        shippingAddress ?? this.shippingAddress,
        image ?? this.image,
        userId ?? this.userId);
  }

  Map<String, Object> toMap() {
    return {
      userId: {
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "phone": phone,
        "emailAddress": emailAddress,
        "shippingAddress": shippingAddress,
        "image": image
      }
    };
  }
}
