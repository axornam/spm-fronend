import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:studentprojectmanager/models/category.dart';
import 'package:xml2json/xml2json.dart';

class Api {
  Dio dio = Dio();

  // static String apiUrl = 'http://192.168.137.1:3000/api/v1';
  static String apiUrl = 'http://192.168.137.1:3000/api/v1';
  static String registerEndPoint = '$apiUrl/users/register';
  static String loginEndPoint = '$apiUrl/users/login';

  static String baseURL = 'https://catalog.feedbooks.com';
  static String publicDomainURL = '$baseURL/publicdomain/browse';
  static String popular = '$publicDomainURL/top.atom';
  static String recent = '$publicDomainURL/recent.atom';
  static String awards = '$publicDomainURL/awards.atom';
  static String noteworthy = '$publicDomainURL/homepage_selection.atom';
  static String shortStory = '$publicDomainURL/top.atom?cat=FBFIC029000';
  static String sciFi = '$publicDomainURL/top.atom?cat=FBFIC028000';
  static String actionAdventure = '$publicDomainURL/top.atom?cat=FBFIC002000';
  static String mystery = '$publicDomainURL/top.atom?cat=FBFIC022000';
  static String romance = '$publicDomainURL/top.atom?cat=FBFIC027000';
  static String horror = '$publicDomainURL/top.atom?cat=FBFIC015000';

  var logger = Logger();

  Future<CategoryFeed> getCategory(String url) async {
    var res = await dio.get(url).catchError((e) {
      throw (e);
    });

    CategoryFeed category;
    if (res.statusCode == 200) {
      Xml2Json xml2json = new Xml2Json();
      xml2json.parse(res.data.toString());
      var json = jsonDecode(xml2json.toGData());
      category = CategoryFeed.fromJson(json);
    } else {
      throw ('Error ${res.statusCode}');
    }
    return category;
  }

  Future<Map<String, dynamic>?> signIn(Map<String, String> body) async {
    // var uri = Uri.parse(loginEndPoint);
    // var response = await http.post(uri, body: body);
    var response = await dio.post(loginEndPoint, data: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // logger.i( response.data);
      // logger.i(data);
      logger.d(response.data?['user'], response.data?['token'].toString());
      return response.data;
    }

    return null;
  }

  Future<Map<String, dynamic>?> register(var body) async {
    return null;
  }
}
