import 'dart:convert';

import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<UserModel> register({ String? name, String? username, String? email, String? password }) async {

    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type' : 'application/json'};
    var body = jsonEncode({
      'name' : name,
      'username' : username,
      'email' : email,
      'password' : password
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if(response.statusCode == 200){
      
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      var token = user.token = 'Bearer ${data['access_token']}';

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email!);
      prefs.setString('password', password!);
      prefs.setString('token', token);

      return user; 

    } else {
      
      throw Exception('Gagal Register');
    
    }
  }

  Future<UserModel> login({ String? email, String? password }) async {

    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type' : 'application/json'};
    var body = jsonEncode({
      'email' : email,
      'password' : password
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    print(response.statusCode);

    if(response.statusCode == 200){
      
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      var token = user.token = 'Bearer ${data['access_token']}';

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email!);
      prefs.setString('password', password!);
      prefs.setString('token', token);

      return user; 

    } else {
      
      throw Exception('Gagal Login');
    
    }
  }

  Future<UserModel> editProfile({
    required String name,
    required String username,
    required String email,
    required String token,
  }) async {
    var url = '$baseUrl/user';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);

      return user;
    } else {
      throw Exception('Gagal Update Profil');
    }
  }

  Future<bool> logout(String token) async{
    var url = Uri.parse('$baseUrl/logout');
    var headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };

    var response = await http.post(
      url,
      headers: headers,
    );

    print(response.body);

    if(response.statusCode == 200){
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      prefs.remove('password');
      prefs.remove('token');

      return true; 

    } else {
      
      throw Exception('Gagal Logout');
    
    }
  }

}