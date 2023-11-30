//masukkan kode khusus untuk client disini (ayas dan stella)

import 'package:ugd_ui_widget/entity/User.dart';

import 'dart:convert';
import 'package:http/http.dart';

class ReservationClient {

  //untuk emulator
  static final String url = '10.0.2.2:8000'; //base url
  static final String endpoint = '/api/reservation'; //base endpoint

  //untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpoint = '/UGD_U_WIDGET/public/api/user';

  //mengambil semua data barang dari API
  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint)); //melakukan req ke api dan menyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      //list.map untuk membuat list objek barang berdasarkan tiap elemen dari list
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data barang dr api berdasarkan id
  static Future<User> find(email) async {
    try {
      var response = await get(Uri.http(url,'$endpoint/$email')); //req ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek barang berdasarkan bagan data dari response body
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //membuat data barang baru
  static Future<Response> create(User user) async {
    try {
      var response = await post(Uri.http(url, endpoint), 
      headers: {'Content-Type': 'application/json'},
      body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengubah data barang sesuai ID
  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'), 
      headers: {'Content-Type': 'application/json'},
      body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //menghapus data barang sesuai ID
  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}