import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datauser/Home1/User.dart';

class UserServices {
  static const ROOT = 'http://10.0.2.2:88/web_restapi/api1/action.php';
  static const String _GET_ACTION = 'GET_DATA';
  static const String _ADD_ACTION = 'ADD_DATA';
  static const String _UPDATE_ACTION = 'UPDATE_DATA';
  static const String _DELETE_ACTION = 'DELETE_DATA';

  static Future<List<User>> getUsers() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseData(response.body);
        return list;
      } else {
        throw List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  static List<User> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<String> addUser(String user_nama, String user_nik) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_ACTION;
      map["user_nama"] = user_nama;
      map["user_nik"] = user_nik;
      final response = await http.post(ROOT, body: map);
      print("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateUser(
      String user_id, String user_nama, String user_nik) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_ACTION;
      map["user_id"] = user_id;
      map["user_nama"] = user_nama;
      map["user_nik"] = user_nik;
      final response = await http.post(ROOT, body: map);
      print("updateUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteUser(String user_id) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_ACTION;
      map["user_id"] = user_id;
      final response = await http.post(ROOT, body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}