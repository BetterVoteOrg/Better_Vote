import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class S3URLResponse {
  bool success;
  String message;
  String uploadUrl;
  String downloadUrl;
  bool isUploaded;
  bool isGenerated;
  S3URLResponse(this.success, this.message, this.uploadUrl, this.downloadUrl,
      this.isGenerated);
}

class S3BucketHandler {
  String _apiHost =
      "https://afb0-2600-8807-307-8800-f08b-bb58-2797-424b.ngrok.io";
  bool _success = false;
  String _message;
  String _uploadUrl;
  String _downloadUrl;
  bool _isGenerated = false;
  S3BucketHandler({String apiHost}) {
    if (apiHost != null) this._apiHost = apiHost;
  }
  Future<S3URLResponse> generatePresignedUrl(String fileType) async {
    try {
      Map body = {"fileType": fileType};
      final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
      Map<String, String> headers = {};
      if (_jsonWebToken != null)
        headers['Authorization'] = 'Bearer ' + _jsonWebToken;
      var response = await http.post(
        Uri.parse('$_apiHost/api/aws/generate-presigned-url'),
        headers: headers,
        body: body,
      );
      var result = jsonDecode(response.body);
      if (result['success'] != null) {
        this._success = result['success'];
        this._message = result['message'];
        if (response.statusCode == 201) {
          this._isGenerated = true;
          this._uploadUrl = result["uploadUrl"];
          this._downloadUrl = result["downloadUrl"];
        }
      }
      return new S3URLResponse(this._success, this._message, this._uploadUrl,
          this._downloadUrl, this._isGenerated);
    } catch (e) {
      print(e);
      throw ('Error getting url');
    }
  }

  Future<bool> uploadImageFileToS3(String genereratedUrl, XFile image) async {
    try {
      Uint8List bytes = await image.readAsBytes();
      var response = await http.put(Uri.parse(genereratedUrl), body: bytes);
      print(response);
      return response.statusCode == 200;
    } catch (e) {
      throw ('Error uploading file.');
    }
  }
}
