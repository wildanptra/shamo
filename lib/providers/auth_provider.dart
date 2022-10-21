import 'package:flutter/material.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({String? name, String? username, String? email, String? password}) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

    Future<bool> editProfile({ required String name, required String username, required String email, required String token, }) async {
      try {
        UserModel user = await AuthService().editProfile(
          name: name,
          username: username,
          email: email,
          token: token,
        );

        _user = user;

        return true;
      } catch (e) {
        print(e);

        return false;
      }
    }

  var result = true;

  Future<bool> logout(String token) async{
    try {
      if(await AuthService().logout(token)){
        result = true;
      }

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
}
