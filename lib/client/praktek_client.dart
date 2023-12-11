import 'package:ugd_ui_widget/entity/Praktek.dart';

import 'dart:convert';
import 'package:http/http.dart';

class doctorClient {
  static final String url = '10.0.2.2:8000'; //base url
  // static final String url = '10.53.11.59:8000'; //base url
  // static final String url = '52.185.188.129:8000'; //base url
  static final String endpoint = '/api/praktek';

  static Future<List<Praktek>> fetchPraktekByDoctor(String id) async {
    try {
      var response = await get(Uri.http(url, "$endpoint/$id"));

      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
        throw Exception(response.reasonPhrase);
      }

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Praktek.fromJson2(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
