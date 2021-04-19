import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:recommendation_vision/CameraScreen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e){
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vision',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: CameraScreen()
    );
  }
}
