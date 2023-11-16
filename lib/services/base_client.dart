import 'dart:convert';
import 'package:my_flutter_project/services/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';

String printToken='';

void signup(String email, String username, String password) async {
  try {
    Response response = await post(
        Uri.parse('http://192.168.56.1:9000/auth/register'),
        body: {'email': email, 'username': username, 'password': password});

    if (response.statusCode == 201) {
      isSuccessSignup = true;
      print('Success');
    } else {
      isSuccessSignup = false;
      print('Failed');
    }
  } catch (e) {
    print(e.toString());
  }
}
//login lay token
void login(String username, String password) async {
  try {
    Response response = await post(Uri.parse('http://192.168.56.1:9000/auth'),
        body: {'username': username, 'password': password});
    print(response.statusCode);
    if (response.statusCode == 200) {
      isSuccessLogin = true;
      Map<String, dynamic> responseBody = json.decode(response.body);
      String savedToken = responseBody['data']['token'];
      await _saveTokenToSharedPreferences(savedToken);
    } else {
      isSuccessLogin = false;
    }
  } catch (e) {
    print(e.toString());
  }
}

_saveTokenToSharedPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  print('Token saved to SharedPreferences');
}








