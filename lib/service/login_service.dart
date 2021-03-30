import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginService extends ChangeNotifier {
  var _user = {};
  get user => _user;

  Future<bool> login(String username, String password) async {
    try {
      final Response response = await Dio().post(
        'https://library-management-2.herokuapp.com/signin',
        data: {
          "ID": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        _user = response.data;
        print(_user['ID']);
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> signup(
      String username, String password, String name, String department) async {
    try {
      final Response response = await Dio()
          .post('https://library-management-2.herokuapp.com/signup', data: {
        "ID": username,
        "password": password,
        "name": name,
        "department": department
      });
      if (response.statusCode == 201) {
        print(response.data);
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> deleteStaff(String id) async {
    try {
      final Response response = await Dio().delete(
          'https://library-management-2.herokuapp.com/delete-staff?id=$id');
      if (response.statusCode == 200) {
        // print(response.data);
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
    return false;
  }
}
