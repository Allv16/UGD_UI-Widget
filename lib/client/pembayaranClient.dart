import 'package:http/http.dart';
import 'package:ugd_ui_widget/model/payment.dart';
import 'dart:convert';

class PaymentClient {

  static final String url = '10.0.2.2:8000'; 
  static final String endpoint = '/api/pembayaranPaid';
    static final String endpoint2 = '/api/pembayaranUnpaid';

  
   static Future<List<Payment>> fetchAllPaid( String email) async {
    try {
      var response = await get(
        Uri.http(url, '$endpoint/$email')); 

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Payment.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Payment>> fetchAllUnpaid( String email) async {
    try {
      var response = await get(
        Uri.http(url, '$endpoint2/$email')); 

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Payment.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }


}