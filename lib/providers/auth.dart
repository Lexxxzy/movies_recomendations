import 'package:flutter/widgets.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movies_recomendations/models/http_exception.dart';
import 'dart:convert';
import '';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSigment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSigment?key=AIzaSyALjs5p96Yf3hyolb-ZbebmMCp5cFT7pjY';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
