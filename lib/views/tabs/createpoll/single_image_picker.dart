import 'package:better_vote/network/FileHandler.dart';
import 'package:better_vote/network/S3BucketHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AddAttachmentModalSheet.dart';
import 'get_image_permission.dart';
import 'package:path/path.dart' as path;

typedef Future<bool> OnSaveImage(String url);
enum PickImageSource { both, gallery, camera }
enum Source { GALLERY, CAMERA, NONE }

class SingleImagePicker {
  final PickImageSource pickImageSource;
  final Function(String path) onImagePicked;
  final Function(String downloadUrl) onImageSuccessfullySaved;
  final OnSaveImage onSaveImage;
  final Function(String message) onImageUploadFailed;

  SingleImagePicker({
    this.pickImageSource,
    @required this.onImagePicked,
    @required this.onSaveImage,
    @required this.onImageSuccessfullySaved,
    @required this.onImageUploadFailed,
  });

  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage(context) async {
    try {
      ImageSource imageSource;
      if (pickImageSource == PickImageSource.both) {
        Size size = MediaQuery.of(context).size;
        var sheet = AddAttachmentModalSheet(size);
        await showModalBottomSheet(
          context: context,
          builder: (context) => sheet,
          isScrollControlled: true,
        );

        if (sheet.source == Source.CAMERA) {
          imageSource = ImageSource.camera;
        } else if (sheet.source == Source.GALLERY) {
          imageSource = ImageSource.gallery;
        } else {
          return;
        }
      } else if (pickImageSource == PickImageSource.camera) {
        imageSource = ImageSource.camera;

        GetImagePermission getPermission = GetImagePermission.camera();
        await getPermission.getPermission(context);

        if (getPermission.granted == false) {
          //Permission is not granted
          return;
        }
      } else if (pickImageSource == PickImageSource.gallery) {
        imageSource = ImageSource.gallery;

        GetImagePermission getPermission = GetImagePermission.gallery();
        await getPermission.getPermission(context);

        if (getPermission.granted == false) {
          //Permission is not granted
          return;
        }
      } else {
        return;
      }

      XFile image = await imagePicker.pickImage(source: imageSource);

      if (image != null) {
        onImagePicked?.call(image.path);

        String fileExtension = path.extension(image.path);
        S3BucketHandler bucketHandler = S3BucketHandler();

        S3URLResponse response =
            await bucketHandler.generatePresignedUrl(fileExtension);

        String uploadUrl;
        // if (response.isGenerated != null && response.isGenerated) {
        //   uploadUrl = response.uploadUrl;
        // } else {
        //   throw response.message;
        // }

        bool isUploaded =
            await bucketHandler.uploadImageFileToS3(uploadUrl, image);

        if (isUploaded != null && response.isUploaded) {
          bool isSaved = await onSaveImage(response.downloadUrl);
          if (isSaved) {
            onImageSuccessfullySaved(response.downloadUrl);
          } else {
            throw "Failed to save image";
          }
        } else {
          throw response.message;
        }
      }
    } catch (e) {
      onImageUploadFailed(e.toString());
    }
  }
}
