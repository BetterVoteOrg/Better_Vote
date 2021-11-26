import 'package:better_vote/views/tabs/createpoll/single_image_picker.dart';

enum PhotoSource { ASSET, NETWORK }
enum PhotoStatus { LOADING, ERROR, LOADED }

class ImageHelper {
  PhotoSource photoSource;
  PhotoStatus photoStatus;
  String source;
  handleImage(context) async {
    final SingleImagePicker singleImagePicker = SingleImagePicker(
      pickImageSource: PickImageSource.both,
      onImagePicked: (String path) {
        print("onImagePicked");
        photoSource = PhotoSource.ASSET;
        source = path;
        photoStatus = PhotoStatus.LOADING;
      },
      onSaveImage: (String url) async {
        print("onSaveImage");
        return true;
      },
      onImageSuccessfullySaved: (String url) {
        print("onImageSuccessfullySaved");
        photoStatus = PhotoStatus.LOADED;
        photoSource = PhotoSource.NETWORK;
        source = url;
      },
      onImageUploadFailed: (String messages) {
        print("onImageUploadFailed");
        photoStatus = PhotoStatus.ERROR;
      },
    );
    singleImagePicker.pickImage(context);
  }
}



// class NotificationsTabState extends State<NotificationsTabPage> {
//   PhotoSource photoSource;
//   PhotoStatus photoStatus;
//   String source;
//   final _userController = UserController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//           builder: notificationsTabBuilder,
//           //Replace with method to fetch notifications
//           future: _userController.findProfileData()),
//     );
//   }

//   Widget notificationsTabBuilder(
//       BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//     if (snapshot.hasData) {
//       const TextStyle optionStyle =
//           TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 height: 200,
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: Container(
//                         color: Colors.grey.shade200,
//                         child: photoSource == PhotoSource.NETWORK
//                             ? Image.network(source, height: 200)
//                             : photoSource == PhotoSource.ASSET
//                                 ? Image.asset(source, height: 200)
//                                 : Container(
//                                     color: Colors.grey.shade200, height: 200),
//                       ),
//                     ),
//                     Center(
//                       child: photoStatus == PhotoStatus.LOADING
//                           ? CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation(Colors.red))
//                           : photoStatus == PhotoStatus.ERROR
//                               ? Icon(MaterialIcons.error,
//                                   color: Colors.red, size: 40)
//                               : Container(),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               RaisedButton(
//                 onPressed: handleImage,
//                 child: Text('Select image'),
//               )
//             ],
//           ),
//         ),
//       );
//     }
//     if (snapshot.hasError) return Text("An error occurred Notifications data.");
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   handleImage() async {
//     final SingleImagePicker singleImagePicker = SingleImagePicker(
//       pickImageSource: PickImageSource.both,
//       onImagePicked: (String path) {
//         print("onImagePicked");
//         setState(() {
//           photoSource = PhotoSource.ASSET;
//           source = path;
//           photoStatus = PhotoStatus.LOADING;
//         });
//       },
//       onSaveImage: (String url) async {
//         print("onSaveImage");
//         return true;
//       },
//       onImageSuccessfullySaved: (String url) {
//         print("onImageSuccessfullySaved");
//         setState(() {
//           photoStatus = PhotoStatus.LOADED;
//           photoSource = PhotoSource.NETWORK;
//           source = url;
//         });
//       },
//       onImageUploadFailed: (String messages) {
//         print("onImageUploadFailed");
//         setState(() {
//           photoStatus = PhotoStatus.ERROR;
//         });
//       },
//     );
//     singleImagePicker.pickImage(context);
//   }
// }

