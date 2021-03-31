import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class FlaskService {
  static const String BASE_URL = 'http://10.0.2.2:5000'; // Sadece emülatörler

  static final FlaskService instance = FlaskService._internal();
  factory FlaskService() => instance;
  FlaskService._internal();
  var logger = Logger();
  Dio _dio = Dio();

  Future postString(String data) async {
    var url = Uri.parse(BASE_URL + '/json_example');
    final response = await _dio.post(url.toString(), data: jsonEncode(<String, String>{'data': data}));

    if (response.statusCode == HttpStatus.ok) {
      logger.d(response.statusCode.toString());
      return json.decode(response.data);
    } else {
      logger.e("Response error");
    }
  }

  Future<Uint8List> postImage(File file) async {
    Uint8List decoded;
    var url = Uri.parse(BASE_URL + '/get_image');
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: "a.png", contentType: MediaType('image', 'png')),
    });

    try {
      var response = await _dio.post(url.toString(), data: formData);
      if (response.statusCode == HttpStatus.ok) {
        logger.d(response.statusCode.toString());
        var _jsonResponse = json.decode(response.data)["img"];
        decoded = base64Decode(_jsonResponse);
      } else {
        logger.e("Response error");
      }
    } on DioError catch (e) {
      print("Error Code: " + e.toString());
    }

    return decoded;
  }
}
