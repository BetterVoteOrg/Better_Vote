import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GenerateImageUrl {
  bool success;
  String message;

  bool isGenerated;
  String uploadUrl;
  String downloadUrl;

  Future<void> call(String fileType) async {
    try {
      Map body = {"fileType": fileType};
      final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
      Map<String, String> headers = {};
      if (_jsonWebToken != null)
        headers['Authorization'] = 'Bearer ' + _jsonWebToken;

      var response = await http.post(
        // Uri.parse(
        //     'http://${Platform.isIOS ? 'localhost' : '10.0.2.2'}:3000/api/generate-image-url'),
        Uri.parse(
            'https://13bf-2600-8807-307-8800-197b-8ad2-1059-bbdf.ngrok.io/api/aws/generate-presigned-url'),
        headers: headers,
        body: body,
      );
      print(response);
      var result = jsonDecode(response.body);
      if (result['success'] != null) {
        success = result['success'];
        message = result['message'];

        if (response.statusCode == 201) {
          isGenerated = true;
          uploadUrl = result["uploadUrl"];
          downloadUrl = result["downloadUrl"];
        }
      }
    } catch (e) {
      throw ('Error getting url');
    }
  }
}
