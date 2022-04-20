import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movies_recomendations/models/http_exception.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String? username,
    String urlSigment,
  ) async {
    final url = '$apiLink/auth/$urlSigment';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            if (username != null) 'username': username,
            'email': email,
            'password': password,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }

      if (urlSigment == 'login') {
        _token = responseData['idToken'];
        _userId = responseData['username'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: responseData['expiresIn'],
          ),
        );
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'expiryDate': _expiryDate!.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json
        .decode(prefs.getString('userData').toString()) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> signUp(String email, String password, String username) async {
    return _authenticate(email, password, username, 'register');
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, null, 'login');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
