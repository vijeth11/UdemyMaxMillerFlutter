class UserModel {
  final String email;
  final String name;
  final String uid;
  final String token;
  final String profilePic;
  UserModel(
      {required this.email,
      required this.name,
      required this.uid,
      required this.token,
      this.profilePic = ""});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "uid": uid,
      "token": token,
      "profilePic": profilePic
    };
  }

  UserModel copyWith(
      {String? email,
      String? name,
      String? uid,
      String? token,
      String? profilePic}) {
    return UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        uid: uid ?? this.uid,
        token: token ?? this.token,
        profilePic: profilePic ?? this.profilePic);
  }
}
