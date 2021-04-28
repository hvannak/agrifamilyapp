import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiHelpers {
  static String _urlSetting = 'https://agrifamily.herokuapp.com/api';

   static Future<http.Response> fetchPost(
      String url, body) async {
        print(Uri.parse(_urlSetting + url));
        print(body);
    final response =
        await http.post(Uri.parse(_urlSetting + url), body: json.encode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    return response;
  }

static Future<http.Response> fetchData(String url, String token) async {
    final response = await http.get(Uri.parse(_urlSetting+ url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': token
    });
    return response;
  }

  static Future<http.Response> fetchDataWithAuth(String url, String auth) async {
    final response = await http.get(Uri.http(_urlSetting, url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': auth
    });
    return response;
  }

  Future<http.Response> fetchPut(
      String url, Map<String, dynamic> body, int id) async {
    var response = await http.put(Uri.http(_urlSetting, url + id.toString()),
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: "Bearer " + _token
        });
    print('Fetch Put');
    return response;
  }

  Future<http.Response> deleteData(String url, int id) async {
    final response =
        await http.delete(Uri.http(_urlSetting, url + id.toString()), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      // HttpHeaders.authorizationHeader: "Bearer " + _token
    });
    return response;
  }

}