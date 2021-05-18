import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/takephoto.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFiles extends StatefulWidget {
  @override
  _ImageFilesState createState() => _ImageFilesState();
}

class _ImageFilesState extends State<ImageFiles> {
  // var _firstCamera;
  // String _imagePath = '';
  List<String> _listBase64 = [];
  List<List<int>> _list = [];
  final picker = ImagePicker();

  @override
  void initState() {
    // _initCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop(null);
          },
        ),
        title: buildText('Fileinput', headertextStyle),
      ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 400,
                  child: GridView.builder(
                    itemCount: _list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                    itemBuilder: (BuildContext context,int index){
                      return Card(                
                        child: Image.memory(Uint8List.fromList(_list[index]),fit: BoxFit.cover,)
                      );
                    }
                  ),                 
                ),
                InkWell(
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  onTap: () {
                    // _navigateTakePictureScreen(context);
                    getImageFromCamera();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Icon(Icons.file_upload),
                    ),
                  ),
                  onTap: () {
                    getImageGallery();
                  },
                ),
                Center(
                  child: MyButtonCallback(
                      myPress: _keepImageFiles, labelText: 'Fileinput'))
              ],
            ),
          ),
        ));
  }

  void _keepImageFiles(){
    Navigator.of(context).pop(_listBase64);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        File imagefile = new File(pickedFile.path);
        List<int> imageBytes = imagefile.readAsBytesSync();
        _list.add(imageBytes);
        _listBase64.add("data:image/png;base64," + base64Encode(imageBytes));
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        File imagefile = new File(pickedFile.path);
        List<int> imageBytes = imagefile.readAsBytesSync();
        _list.add(imageBytes);
        _listBase64.add("data:image/png;base64," + base64Encode(imageBytes));
      } else {
        print('No image selected.');
      }
    });
  }

  // Future<void> _initCamera() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final cameras = await availableCameras();
  //   _firstCamera = cameras.first;
  // }

  // _navigateTakePictureScreen(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) =>
  //             TakePhoto(key: UniqueKey(), camera: _firstCamera),
  //         fullscreenDialog: true),
  //   );
  //   if (result != null) {
  //     imageCache!.clear();
  //     setState(() {
  //       _imagePath = result;
  //       File imagefile = new File(_imagePath);
  //       List<int> imageBytes = imagefile.readAsBytesSync();
  //       _list.add(imageBytes);
  //       _imagebase64 = "data:image/png;base64," + base64Encode(imageBytes);
  //     });
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Image is captured")));
  //   }
  // }
}
