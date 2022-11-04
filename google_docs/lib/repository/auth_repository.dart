import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/constatnts.dart';
import 'package:google_docs/model/error_model.dart';
import 'package:google_docs/model/user_model.dart';
import 'package:google_docs/repository/local_storage_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider((_) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepository: LocalStorageRepository()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required Client client,
      required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;

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
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel =
        ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      String? token = await _localStorageRepository.getToken();
      if (token != null) {
        var res = await _client.get(Uri.parse("$host/"), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });
        Map<String, dynamic> resBody = json.decode(res.body);
        switch (res.statusCode) {
          case 500:
            errorModel = ErrorModel(error: resBody["error"], data: null);
            break;
          case 200:
            final newUser = UserModel(
                uid: resBody["user"]["_id"],
                email: resBody["user"]["email"],
                name: resBody["user"]["name"],
                profilePic: resBody["user"]["profilePic"],
                token: token);
            errorModel = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }

  void signOut() async {
    await _googleSignIn.signOut();
    _localStorageRepository.setToken('');
  }
}
