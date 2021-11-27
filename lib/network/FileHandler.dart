import 'package:image_picker/image_picker.dart';

class FileHandler {
  ImagePicker picker = ImagePicker();
  Future<XFile> getImageFromCamera() async {
    return await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
  }

  Future<XFile> getImageFromGallery() async {
    return await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
  }
}
