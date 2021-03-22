import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Books extends ChangeNotifier {
  var _books = {};
  get books => _books;

  Future book() async {
    try {
      final Response response =
          await Dio().get('https://good-seahorse-0.loca.lt');
      if (response.statusCode == 200) {
        _books = response.data;
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future bookupdate() async {
    try {
      final Response response = await Dio().patch(
          'https://good-seahorse-0.loca.lt/update-books',
          data: jsonEncode({"materialstatus": "no"}));
      if (response.statusCode == 200) {
        print(response);
      }
    } on SocketException {
      print("no conection");
    }
  }
}
