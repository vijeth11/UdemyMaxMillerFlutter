import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:grocia/model/address_model.dart';
import 'package:grocia/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/HttpException.dart';

class AuthProvider extends ChangeNotifier {
  late UserModel _userDetail;
  late String? _token;
  DateTime? _expiryDate;
  late String? _userId;
  Timer? _authTimer = null;
  
  AuthProvider();

  UserModel get item {
    return _userDetail;
  }

  String get displayName {
    return item.displayName;
  }

  String? get token {
    if (_expiryDate != null &&
        (_expiryDate ?? DateTime.now()).isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password, String username, String phone) async {
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCVrSn749U65LtR5yHfDpp_Cgq9ICG8KGo";
      await _authenticate(email, password, url, false);
      _userDetail = UserModel(displayName: username,phoneNumber: phone,userEmail: email,userId: _userId!,profileImage: '',addresses: []);
      await updateUserProfile();
      return _storeLoggedInUserData();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      const url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCVrSn749U65LtR5yHfDpp_Cgq9ICG8KGo";
      await _authenticate(email, password, url, true);
      await fetchUserDetails();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUserProfile() async {
    var response = await http.put(
        Uri.parse(
            'https://gocia-vegetable-fruits-market-default-rtdb.firebaseio.com/users.json?auth=$_token'),
        body: json.encode(_userDetail.toMap()));
    var responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
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
      'userName': item.displayName
    });
    prefs.setString('userData', userdata);
  }

  Future<void> fetchUserDetails() async {
    var response = await http.get(Uri.parse(
        'https://gocia-vegetable-fruits-market-default-rtdb.firebaseio.com/users/$_userId.json'));
    if (response.body != "null") {
      final userdetails = json.decode(response.body) as Map<String, dynamic>;
      print(userdetails);
      _userDetail = UserModel(userId: _userId!,
      displayName: userdetails["displayName"],
      phoneNumber: userdetails["PhoneNumber"],
      userEmail: userdetails["email"],
      profileImage: userdetails["profileImage"],
      addresses: _getUserAddress(userdetails));
    }
  }

  List<AddressModel> _getUserAddress(dynamic data){
    List<AddressModel> userAddress = [];
    for(var item in  data){
      userAddress.add(AddressModel(
        Address: item["address"], 
        ZipCode: item["ZipCode"], 
        City: item["City"], 
        Country: item["Country"], 
        UserName: item["UserName"], 
        UserPhone: item["UserPhone"], 
        UserEmail: item["UserEmail"], 
        addressType: item["addressType"],
        isDefault: item["isDefault"]));
    }
    return userAddress;
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0"),
        body: json.encode({"email": email, "requestType": "PASSWORD_RESET"}));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
  }

  Future<void> passwordReset(String email, String password, String code) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:resetPassword?key=AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0";
    var response =
        await http.post(Uri.parse(url), body: json.encode({"oobCode": code}));
    var responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    } else {
      response = await http.post(Uri.parse(url),
          body: json.encode({"oobCode": code, "newPassword": password}));
      responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
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
    await fetchUserDetails();
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
        storageRef.child('UserProfileImage').child('${_userDetail.displayName}.png');
    await userProfileImage.putFile(userProfile);
    _userDetail =
        _userDetail.copyTo(profileImage: await userProfileImage.getDownloadURL());
  }
}
