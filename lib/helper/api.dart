import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('there is an error in statue code');
    }
  }

  Future<dynamic> post({
    required String url,
    @required dynamic body,
  }) async {
    http.Response response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'there is an error in status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put({
    required String url,
    @required dynamic body,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    print("url is $url  body is $body  headers are $headers");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is an error in status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
