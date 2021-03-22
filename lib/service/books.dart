import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Books extends ChangeNotifier {
  var _books = [];
  get books => _books;

  Future book() async {
    try {
      final Response response =
          await Dio().get('https://odd-walrus-49.loca.lt/');
      if (response.statusCode == 200) {
        _books = response.data;
        print(_books);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future bookupdate(String id, String available) async {
    try {
      final Response response = await Dio().patch(
          'https://odd-walrus-49.loca.lt/update-books?id=$id',
          data: jsonEncode({"materialStatus": available}));
      if (response.statusCode == 200) {
        print(response.data);
      }
    } on SocketException {
      print("no conection");
    }
  }
}
