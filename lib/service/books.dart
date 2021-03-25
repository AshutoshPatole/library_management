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
          await Dio().get('https://thin-ladybug-9.loca.lt/');
      if (response.statusCode == 200) {
        _books = response.data;
        print(_books);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future bookupdate(String account, title, author, edition, pubYear, callNo,
      publisher, materialStatus, materialType) async {
    try {
      final Response response = await Dio()
          .post('https://thin-ladybug-9.loca.lt/update-books', data: {
        "author": author,
        "title": title,
        "edition": int.parse(edition),
        "pubYear": int.parse(pubYear),
        "publisher": publisher,
        "callNo": callNo,
        "materialStatus": materialStatus,
        "materialType": materialType,
        "accNo": account,
      });
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      print("no conection");
    }
  }
}
