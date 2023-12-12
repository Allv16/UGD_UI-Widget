import 'package:http/http.dart';
import 'package:ugd_ui_widget/model/payment.dart';
import 'dart:convert';

class PaymentClient {
  // static final String url = '10.0.2.2:8000';
  static final String url = '52.185.188.129:8000';
  static final String endpoint = '/api/pembayaranPaid';
  static final String endpoint2 = '/api/pembayaranUnpaid';
  static final String endpointPembayaran = '/api/pembayaran'; //base endpoint
  static final String endpointPaid = '/api/paid'; //b

  static Future<List<Payments>> fetchAllPaid(String email) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$email'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Payments.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Payments>> fetchAllUnpaid(String email) async {
    try {
      var response = await get(Uri.http(url, '$endpoint2/$email'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Payments.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateJenisPembayaran(
      int id, String jenisPembayaran) async {
    try {
      var response = await put(Uri.http(url, endpointPembayaran),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"jenis_pembayaran": jenisPembayaran, "id": id}));
      // print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> payPayment(int id) async {
    try {
      var response = await put(Uri.http(url, '$endpointPaid'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"id": id}));
      // print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> canclePayment(int id) async {
    try {
      var response = await put(Uri.http(url, '$endpointPembayaran/cancle/$id'),
          headers: {'Content-Type': 'application/json'});
      // print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
