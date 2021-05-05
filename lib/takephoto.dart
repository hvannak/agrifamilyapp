
import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePhoto extends StatefulWidget {
  final CameraDescription camera;

  const TakePhoto({
    required Key key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String _path = '';
  String _nullpath = '';
  _isExistedFile() async {
    _path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      'image.png',
    );

    // Attempt to take a picture and log where it's been saved.
    io.File(_path).exists().then((val) {
      if (val == true) {
        final dir = io.Directory(_path);
        dir.deleteSync(recursive: true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    _isExistedFile();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context, _nullpath);
            },
          ),
        title: Text('Take a picture'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
         try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // await _controller.takePicture(_path);
            var xFile = await _controller.takePicture();

            Navigator.of(context).pop(xFile.path);
            //  Navigator.pop(context, base64Image);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
      )
    );
  }
}
