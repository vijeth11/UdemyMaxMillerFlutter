import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/constatnts.dart';
import 'package:google_docs/model/error_model.dart';
import 'package:google_docs/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
    (_) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userModel = UserModel(
            email: user.email,
            name: user.displayName ?? "",
            token: '',
            uid: '',
            profilePic: user.photoUrl ?? "");
        var res = await _client.post(Uri.parse("$host/api/signup"),
            body: json.encode(userModel.toMap()),
            headers: {'Content-Type': 'application/json; charset=UTF-8'});
        Map<String, dynamic> resBody = json.decode(res.body);
        switch (res.statusCode) {
          case 500:
            error = ErrorModel(error: resBody["error"], data: null);
            break;
          case 200:
            final newUser = userModel.copyWith(
                uid: resBody["user"]["_id"],
                email: resBody["user"]["email"],
                name: resBody["user"]["name"],
                profilePic: resBody["user"]["profilePic"],
                token: resBody["token"]);
            error = ErrorModel(error: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  //Future<ErrorModel> 
}
