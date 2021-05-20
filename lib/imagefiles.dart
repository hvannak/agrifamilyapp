import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:agrifamilyapp/modules/mypostfunc.dart';
import 'package:agrifamilyapp/takephoto.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'models/imagedatamodel.dart';

class ImageFiles extends StatefulWidget {
  final List<Postimagemodel> postimageList;
  final bool editmode;
  ImageFiles(this.postimageList,this.editmode);
  @override
  _ImageFilesState createState() => _ImageFilesState();
}

class _ImageFilesState extends State<ImageFiles> {
  // var _firstCamera;
  // String _imagePath = '';
  List<String> _listBase64 = [];
  List<Postimagemodel> _listRemove = [];
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
                    itemCount: widget.postimageList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                    itemBuilder: (BuildContext context,int index){                    
                      return Stack(
                        children: [
                          Card(                
                            child: Image.memory(Uint8List.fromList(reInstantiatePostImageCodec(widget.postimageList[index].image!.data)),fit: BoxFit.cover,)
                          ),
                          InkWell(
                            child: Container(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                            child: Icon(Icons.delete_forever),
                          ),
                          ),
                          onTap: (){
                            _listRemove.add(Postimagemodel(widget.postimageList[index].id, null, widget.postimageList[index].post));
                            setState(() {
                              widget.postimageList.removeAt(index);
                            });
                          },
                          )
                        ],
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
    if(_listBase64.length > 0 || _listRemove.length > 0){
      Navigator.of(context).pop([_listBase64,_listRemove]);
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        File imagefile = new File(pickedFile.path);
        List<int> imageBytes = imagefile.readAsBytesSync();
        var fileBuffer = "data:image/png;base64," + base64Encode(imageBytes);
        _listBase64.add(fileBuffer);
        widget.postimageList.add(Postimagemodel(null,Imagedatamodel('buffer',imageBytes), null));
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
        var fileBuffer = "data:image/png;base64," + base64Encode(imageBytes);
        _listBase64.add(fileBuffer);
        widget.postimageList.add(Postimagemodel(null,Imagedatamodel('buffer',imageBytes), null));
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
