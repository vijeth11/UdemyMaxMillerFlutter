import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late String? _token;
  DateTime? _expiryDate;
  late String? _userId;
  Timer? _authTimer;
  late String? _userName;
  late UserDetails userDetails;
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
      userDetails = UserDetails('', '', username, '', email, '', '', userId);
      await updateUserProfile();
      return _storeLoggedInUserData();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0";
      await _authenticate(email, password, url, true);
      await fetchUserDetails();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUserProfile() async {
    var response = await http.put(
        Uri.parse(
            'https://flutter-kedo-food-default-rtdb.firebaseio.com/users.json?auth=$_token'),
        body: json.encode(userDetails.toMap()));
    var responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    } else {
      _userName = userDetails.userName;
    }
    notifyListeners();
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
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      if (isLogin) {
        _userName = responseData['displayName'];
        await _storeLoggedInUserData();
      }
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
      'expiryDate': _expiryDate?.toIso8601String(),
      'userName': _userName
    });
    prefs.setString('userData', userdata);
  }

  Future<void> fetchUserDetails() async {
    var response = await http.get(Uri.parse(
        'https://flutter-kedo-food-default-rtdb.firebaseio.com/users/$userId.json?auth=$_token'));
    if (response.body != "null") {
      final userdetails = json.decode(response.body) as Map<String, dynamic>;
      print(userdetails);
      userDetails = UserDetails(
          userdetails['firstName'],
          userdetails['lastName'],
          userdetails['userName'],
          userdetails['phone'],
          userdetails['emailAddress'],
          userdetails['shippingAddress'],
          userdetails['image'],
          userId);
    }
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
    _userName = extractData['userName'];
    await fetchUserDetails();
    if (_userName == null || _userName!.isEmpty) {
      _userName = userDetails.userName;
    }
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

  Future<void> uploadUserProfile(File userProfile) async {
    final storageRef = FirebaseStorage.instance.ref();
    final userProfileImage =
        storageRef.child('UserProfileImage').child('${_userName!}.png');
    await userProfileImage.putFile(userProfile);
    userDetails =
        userDetails.copyTo(image: await userProfileImage.getDownloadURL());
  }
}
