import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiHelpers {
  static String _urlSetting = 'https://agrifamily.herokuapp.com/api';
  // static String _urlSetting = 'http://192.168.100.62:3000/api';

static Future<http.Response> fetchPost(
      String url, body) async {
    final response =
        await http.post(Uri.parse(_urlSetting + url), body: json.encode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    return response;
  }

static Future<http.Response> fetchPostWithAuth(
      String url, body,String token) async {
    final response =
        await http.post(Uri.parse(_urlSetting + url), body: json.encode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': token
    });
    return response;
  }

static Future<http.Response> fetchDataWithAuth(String url, String token) async {
    final response = await http.get(Uri.parse(_urlSetting+ url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': token
    });
    return response;
  }

static Future<http.Response> fetchData(String url) async {
    final response = await http.get(Uri.parse(_urlSetting+ url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    return response;
  }

static Future<http.Response> fetchPutWithAuth(
      String url,body,String token) async {
    var response = await http.put(Uri.parse(_urlSetting + url),
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'auth-token': token
        });
    return response;
  }

 static Future<http.Response> deleteData(String url, String id,String token) async {
    final response =
        await http.delete(Uri.parse(_urlSetting + url + id), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': token
    });
    return response;
  }

}