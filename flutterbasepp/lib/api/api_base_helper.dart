import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions/app_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    final fullUrl = Uri.parse(_baseUrl + url);

    var responseJson;
    try {
      final response = await http.get(fullUrl);
      responseJson = _returnResponse(response);
    } on Exception catch (ex) {
      print('No net $ex');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    final fullUrl = Uri.parse(_baseUrl + url);
    var responseJson;
    try {
      final response = await http.post(
        fullUrl,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    final fullUrl = Uri.parse(_baseUrl + url);
    try {
      final response = await http.put(
        fullUrl,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    final fullUrl = Uri.parse(_baseUrl + url);

    var apiResponse;
    try {
      final response = await http.delete(fullUrl);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
