import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Books extends ChangeNotifier {
  var _books = [];
  get books => _books;

  var _ubooks = [];
  get ubooks => _ubooks;

  var _staff = [];
  get staff => _staff;

  var _report = {};
  get report => _report;

  Future book() async {
    try {
      final Response response =
          await Dio().get('https://library-management-2.herokuapp.com/');
      if (response.statusCode == 200) {
        _books = response.data;
        print(_books);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future staffs() async {
    try {
      final Response response =
          await Dio().get('https://library-management-2.herokuapp.com/staff');
      if (response.statusCode == 200) {
        _staff = response.data;
        print(_staff);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future updatedBooks() async {
    try {
      final Response response =
          await Dio().get('https://library-management-2.herokuapp.com/report');
      if (response.statusCode == 200) {
        _ubooks = response.data;
        print(_ubooks);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future detailreport(String id) async {
    try {
      final Response response = await Dio().get(
          'https://library-management-2.herokuapp.com/fetch-report?_id=$id');
      if (response.statusCode == 200) {
        _report = response.data;
        print(_report);
        notifyListeners();
      }
    } on SocketException {
      print("no conection");
    }
  }

  Future bookupdate(String editedby, staffname, staffdept, bookscanned,
      booktagged, List taggedbooks) async {
    try {
      final Response response = await Dio().post(
          'https://library-management-2.herokuapp.com/update-books',
          data: {
            "editedBy": editedby,
            "staffName": staffname,
            "staffDept": staffdept,
            "bookScanned": bookscanned,
            "bookTagged": booktagged,
            "taggedBooks": taggedbooks
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
