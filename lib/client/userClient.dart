import 'package:ugd_ui_widget/model/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/user';
  static final String loginEndpoint = '/api/login';

  static Future<Response> register(User user) async {
    print(user.toRawJson());
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {'Content-Type': 'application/json'},
          body: user.toRawJson());
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User?> login(String email, String password) async {
    try {
      var response = await post(Uri.http(url, loginEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      if (response.statusCode != 200) {
        return null;
      }
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> checkEmail(String email) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$email'));
      if (response.statusCode != 200) {
        return false;
      }
      // Return true if email exists
      return true;
    } catch (e) {
      // Throw an exception to propagate the error
      throw Exception(e.toString());
    }
  }

//updatePhoto
  static Future<bool> updateProfile(int id, String photoUrl) async {
    var url = Uri.parse('http://10.0.2.2:8000/user/{id}/profile/$id');
    var response = await put(url, headers: {
      'Authorization': 'Bearer YOUR_API_TOKEN',
    }, body: json.encode({
      'photo_url': photoUrl,
    }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
  

