import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:recommendation_vision/image_detail.dart';
import 'package:recommendation_vision/main.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = CameraController(cameras[0],ResolutionPreset.medium);
    _controller.initialize().then((_) {
        if(!mounted){
          return;
        }
        setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

Future<String> _takePicture() async {
  //Check if controller is initialized.
  Future<String> _takePicture() async{
    if(!_controller.value.isInitialized){
      print("Controller is not initialized.");
    }
  }

  // Formatting Date & Time
  String dateTime = DateFormat.yMMMd().addPattern('-').add_Hms().format(DateTime.now()).toString();
  String formattedDateTime = dateTime.replaceAll(' ','');
  print("Formatted: $formattedDateTime");

//  Retrive the path for saving the image
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String visionDir = '${appDocDir.path}/Photos/Vision\ Images';
  await Directory(visionDir).create(recursive: true);
  final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

  if(_controller.value.isTakingPicture){print("Processing is in progress");return null;}

  try{
    //capture the image and store it in the provided path.
    await _controller.takePicture(imagePath);
  } on CameraException catch(e){
    print("Camera Exception: $e");
    return null;
  }

  return imagePath;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vision'),
      ),
      body: _controller.value.isInitialized
          ? Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Click"),
                onPressed: () async {
                  await _takePicture().then((String path) {
                    if (path != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(path),
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          )
        ],
      )
          : Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index){},
      ),
    );
  }
}
