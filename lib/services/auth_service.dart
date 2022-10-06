import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/providers/auth_provider.dart';

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
      user.token = 'Bearer ' + data['access_token'];

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

    if(response.statusCode == 200){
      
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user; 

    } else {
      
      throw Exception('Gagal Login');
    
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

      return true; 

    } else {
      
      throw Exception('Gagal Logout');
    
    }
  }

}