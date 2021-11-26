import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FileHandler {
  bool success;
  String message;
  bool isUploaded;
  Future<void> uploadImage(String url, XFile image) async {
    try {
      Uint8List bytes = await image.readAsBytes();

      var response = await http.put(Uri.parse(url), body: bytes);
      print("SADSSSSSSSS" + response.statusCode.toString());
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
