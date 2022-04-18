import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/authentication/components/my_snack_bar.dart';
import 'movies_provider.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String? nickName;
  String? email;
  String? name, realname;
  int? favourites, loved, disliked;
  String? avatar;
  final String? authToken;

  User(
      {this.authToken,
      this.user,
      this.avatar,
      this.nickName,
      this.realname,
      this.email,
      this.name,
      this.favourites,
      this.loved,
      this.disliked});

  User? user;

  Future<void> fetchAndSetUser() async {
    const url = 'http://192.168.1.142:5000/api/v1/auth/user';
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      });

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData = Map<String, dynamic>.from(json.decode(source));
      final User loadedUser = User(
        authToken: authToken,
        nickName: extractedData['username'],
        avatar: extractedData['avatar'] == null
            ? 'http://192.168.1.142:5000/api/v1/auth/files/default-avatar.png'
            : 'http://192.168.1.142:5000/api/v1/auth/files/${extractedData['avatar']}',
        favourites: extractedData['favourites'],
        disliked: extractedData['dislikes'],
        loved: extractedData['likes'],
        email: extractedData['email'],
        name: extractedData['realname'] ?? 'No Name',
      );
      user = loadedUser;
      notifyListeners();
    } on Exception catch (e) {}
  }

  Future uploadImage(selectedImage, context) async {
    try {
      final request = http.MultipartRequest(
          "POST", Uri.parse('http://192.168.1.142:5000/api/v1/auth/setavatar'));

      final header = {
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer $authToken',
      };

      request.files.add(
        http.MultipartFile('image', selectedImage!.readAsBytes().asStream(),
            selectedImage!.lengthSync(),
            filename: selectedImage!.path.split('/').last),
      );

      request.headers.addAll(header);
      final response = await request.send();

      http.Response res = await http.Response.fromStream(response);
      if (!res.body.contains('error')) {
        const mySnackBar(
                message: 'Your profile was updated successfully!',
                isError: false)
            .build(context);
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }

  Future updateNameAndNick(realname, nickname, context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.142:5000/api/v1/auth/update'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(
          {
            'realname': realname,
            'nickname': nickname,
          },
        ),
      );

      print(
        jsonEncode(
          {
            'realname': realname,
            'nickname': nickname,
          },
        ),
      );

      final responseJSON = json.decode(response.body) as Map<String, dynamic>;

      if (responseJSON.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(message: responseJSON['error'] as String, isError: true)
                .build(context));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(
                  message: 'Your profile was updated successfully!',
                  isError: false)
              .build(context),
        );
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }
}
