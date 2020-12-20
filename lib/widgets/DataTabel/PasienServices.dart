import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasien/widgets/DataTabel/Pasien.dart';

class PasienServices {
  static const ROOT = 'http://10.0.2.2:88/web_login/action.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_PAS_ACTION = 'ADD_PAS';
  static const String _UPDATE_PAS_ACTION = 'UPDATE_PAS';
  static const String _DELETE_PAS_ACTION = 'DELETE_PAS';

  static Future<List<Pasien>> getPasiens() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getPasiens >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Pasien> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<Pasien>();
      }
    } catch (e) {
      return List<Pasien>();
    }
  }

  static List<Pasien> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pasien>((json) => Pasien.fromJson(json)).toList();
  }

  static Future<String> createTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _CREATE_TABLE;
      final response = await http.post(ROOT, body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addPasien(String identitas, String status) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_PAS_ACTION;
      map["identitas"] = identitas;
      map["status"] = status;
      final response = await http.post(ROOT, body: map);
      print("addPasien >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updatePasien(
      String empId, String identitas, String status) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_PAS_ACTION;
      map["emp_id"] = empId;
      map["identitas"] = identitas;
      map["status"] = status;
      final response = await http.post(ROOT, body: map);
      print("deletePasien >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deletePasien(String empId) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_PAS_ACTION;
      map["emp_id"] = empId;
      final response = await http.post(ROOT, body: map);
      print("deletePasien >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}