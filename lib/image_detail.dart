import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {

  final String path;
  _DetailScreenState(this.path);

  Size _imageSize;
  String recognizedText = "Loading ...";

  void _initializeVision() async {
    //TODO: initialize the text recognizer here
  }

  Future<void> _getImageSize(File imageFile) async{
    //TODO: Retrieve image size here
    final Completer<Size> completer = Completer<Size>();
    final Image image = Image.file(imageFile);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _){
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Details"),
      ),
      body: Container(),
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
