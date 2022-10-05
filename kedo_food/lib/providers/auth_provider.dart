import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late String? _token;
  DateTime? _expiryDate;
  late String? _userId;
  Timer? _authTimer;
  late String? _userName;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId ?? "";
  }

  String get displayName {
    return _userName ?? '';
  }

  String? get token {
    if (_expiryDate != null &&
        (_expiryDate ?? DateTime.now()).isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password, String username) async {
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0";
      await _authenticate(email, password, url, false);
      return _updateUserProfile(username);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0";
      return _authenticate(email, password, url, true);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _updateUserProfile(String username) async {
    var response = await http.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0"),
        body: json.encode({
          "idToken": _token,
          "displayName": username,
          "photoUrl": "",
          "returnSecureToken": true
        }));
    var responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    } else {
      _userName = responseData['displayName'];
    }
  }

  Future<void> _authenticate(
      String email, String password, String url, bool isLogin) async {
    var response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    var responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    } else {
      _token = responseData['idToken'];
       _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
     await _storeLoggedInUserData();
    }
  }

  Future<void> _storeLoggedInUserData() async {   
    print(_token);
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userdata = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate?.toIso8601String()
    });
    prefs.setString('userData', userdata);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractData['token'];
    _userId = extractData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    _authTimer = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    int expirySeconds = _expiryDate?.difference(DateTime.now()).inSeconds ?? 0;
    // test if auto logout works if you are in other screen
    _authTimer = Timer(Duration(seconds: expirySeconds), () {
      print('auto logout');
      logout();
    });
  }
}
