import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ChangeNotifier {
  var _user = {};
  get user => _user;

  Future<bool> login(String username, String password) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    try {
      final Response response = await Dio().post(
        'https://thin-ladybug-9.loca.lt/signin',
        data: {
          "ID": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        _user = response.data;
        print(_user['ID']);
        _preference.setString("id", _user['ID']);
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
