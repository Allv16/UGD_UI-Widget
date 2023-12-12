import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ugd_ui_widget/model/user.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class UserClient {
  // static final String url = '10.0.2.2:8000';
  // static final String url = '10.53.11.59:8000'; //base url
  static final String url = '52.185.188.129:8000';
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

  static Future<void> updateProfilePictureOld(String email, String path) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/$email/profile'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'profile_path': path}));
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String> updateProfilePicture(
      String email, XFile imageFile) async {
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("http://$url$endpoint/$email/profile"));
      var pict = await http.MultipartFile.fromPath("image", imageFile.path);
      request.files.add(pict);
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return jsonDecode(responseString)['data'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateProfile(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.email}'),
          headers: {'Content-Type': 'application/json'},
          body: user.toRawJson());
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateBPJS(String email, String bpjs) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/$email/bpjs'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'bpjs': bpjs}));
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
