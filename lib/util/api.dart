import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentprojectmanager/models/category.dart';
import 'package:http_parser/http_parser.dart';
import 'package:xml2json/xml2json.dart';

class Api {
  Dio dio = Dio();

  // static String apiUrl = 'http://172.20.10.1:3000/api/v1';
  // static String apiUrl = 'http://192.168.137.1:3000/api/v1';
  static String apiUrl = 'http://full-spm-api.herokuapp.com/api/v1';
  static String searchUrl = 'http://spm-search.herokuapp.com/api';
  static String searchUrlLocal = 'http://127.0.0.1:8000/search/query/';
  static String registerEndPoint = '$apiUrl/users/register';
  static String loginEndPoint = '$apiUrl/users/login';
  static String getCategoriesEndPoint = '$apiUrl/categories';
  static String uploadProjectEndPoint = '$apiUrl/projects';

  var logger = Logger();

  Future<Map<String, dynamic>> doSearch(String searchQuery) async {
    Map<String, dynamic> res = {"": ""};
    Uri uri = Uri.parse(searchUrlLocal + searchQuery);
    http.Response response =
        await http.get(uri, headers: {'Content-Type': 'Application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success", "body": json.decode(response.body)};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed", "body": response.body};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }

    // logger.d(res);
    return res;
  }

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
    var uri = Uri.parse(loginEndPoint);
    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    logger.d(response.statusCode, response.body);

    Map<String, dynamic> res;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success", "body": json.decode(response.body)};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed", "body": response.body};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }
    return res;
  }

  Future<Map<String, dynamic>?> register(Map<String, String> body) async {
    var uri = Uri.parse(registerEndPoint);
    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    logger.d(response.statusCode, response.body);

    Map<String, dynamic> res;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success", "body": json.decode(response.body)};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed", "body": response.body};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }
    return res;
  }

  Future<Map<String, dynamic>?> uploadProject(
      Map<String, String> body, String? filePath, String? imagePath) async {
    var uri = Uri.parse(uploadProjectEndPoint);

    var sp = await SharedPreferences.getInstance();
    List<String>? user = await sp.getStringList("user");
    String token = user![1];

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest("POST", uri);
    request.fields.addAll(body);
    request.headers.addAll(headers);

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath("image", imagePath!,
          contentType: MediaType('image', 'jpg')));
      // request.files.add(new http.MultipartFile.fromBytes(
      //     'file', await File.fromUri(Uri.parse(imagePath)).readAsBytes(),
      //     contentType: new MediaType('image', 'jpeg')));
    }

    if (filePath != null) {
      request.files
          .add(await http.MultipartFile.fromPath('document', filePath!));
      // request.files.add(new http.MultipartFile.fromBytes(
      //     'file', await File.fromUri(Uri.parse(filePath)).readAsBytes(),
      //     contentType: new MediaType('image', 'jpeg')));
    }

    // logger.i([
    //   request.files.first,
    //   request.files.last,
    // ]);

    var response = await request.send();
    logger.i([response.stream, response.statusCode]);
    // final res = await http.Response.fromStream(response);
    Map<String, dynamic> res;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success"};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed"};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }

    return res;
  }

  Future<Map<String, dynamic>?> getCategories() async {
    Uri uri = Uri.parse(getCategoriesEndPoint);
    http.Response response =
        await http.get(uri, headers: {'Content-Type': 'Application/json'});

    Map<String, dynamic> res;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success", "body": json.decode(response.body)};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed", "body": response.body};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }

    // logger.d(res);
    return res;
  }

  Future<Map<String, dynamic>?> getProjects() async {
    Uri uri = Uri.parse(uploadProjectEndPoint);
    http.Response response =
        await http.get(uri, headers: {'Content-Type': 'Application/Json'});

    Map<String, dynamic> res;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // user found
      res = {"message": "success", "body": json.decode(response.body)};
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // user not found
      res = {"message": "failed", "body": response.body};
    } else if (response.statusCode >= 500) {
      // server error
      res = {"message": "error", "body": null};
    } else {
      res = {};
    }

    logger.d(res);

    return res;
  }
}
