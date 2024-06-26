import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/*
약간 수정해야함
 */

Future<Map<String, dynamic>> listDetailPost(
    {required int transId, required bool send}) async {

  String url = dotenv.env['EXCHANGE_LOCAL_URL']!;
  String baseUrl = '${url}/api/exchange/remittance/history/${transId}'; //base

  try {
    http.Response response = await http
        .post(Uri.parse(baseUrl), body: jsonEncode({"sender": send}), headers: {
      "accept": "*/*",
      "Content-Type": "application/json",
    });

    try {
      Map<String, dynamic> resBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;
      return resBody;
    } catch (e) {
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}
