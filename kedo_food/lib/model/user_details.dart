class UserDetails {
  final String firstName;
  final String lastName;
  final String userName;
  final String phone;
  final String emailAddress;
  final String shippingAddress;
  final String image;

  UserDetails(this.firstName, this.lastName, this.userName, this.phone,
      this.emailAddress, this.shippingAddress, this.image);

  String get fullName {
    return firstName + " " + lastName;
  }
}
