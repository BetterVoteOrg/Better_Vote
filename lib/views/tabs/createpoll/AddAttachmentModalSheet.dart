import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'get_image_permission.dart';
import 'single_image_picker.dart';

// ignore: must_be_immutable
class AddAttachmentModalSheet extends StatefulWidget {
  final Size screenSize;
  Source source = Source.NONE;

  AddAttachmentModalSheet(this.screenSize);

  @override
  _AddAttachmentModalSheetState createState() =>
      _AddAttachmentModalSheetState();
}

class _AddAttachmentModalSheetState extends State<AddAttachmentModalSheet> {
  _buildHeading(String text) {
    return Text(text, style: TextStyle(fontSize: 26, color: Colors.black));
  }

  _buildCloseButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(MaterialIcons.close, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildHeading('Upload'),
                _buildCloseButton(context)
              ],
            ),
            SizedBox(height: 16),
            _buildOption(FontAwesome.camera, 'Camera',
                () => _onPickFromCameraClicked(context)),
            _buildOption(MaterialIcons.photo_library, 'Photo library',
                () => _onAddPhotoClicked(context)),
          ],
        ),
      ),
    );
  }

  _buildOption(IconData optionIcon, String optionName, Function onItemClicked) {
    return GestureDetector(
      onTap: onItemClicked,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(optionIcon),
            SizedBox(width: 8),
            Text(
              optionName,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  _onAddPhotoClicked(context) async {
    GetImagePermission getPermission = GetImagePermission.gallery();
    await getPermission.getPermission(context);

    if (getPermission.granted) {
      widget.source = Source.GALLERY;
      Navigator.pop(context);
    }
  }

  _onPickFromCameraClicked(context) async {
    GetImagePermission getPermission = GetImagePermission.camera();
    await getPermission.getPermission(context);

    if (getPermission.granted) {
      widget.source = Source.CAMERA;
      Navigator.pop(context);
    }
  }
}
