import 'package:flutter/material.dart';
import 'Image_picker/image_picker_screen.dart';
import 'camerascreen/camera_screen.dart';

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Picker Demo',
      home: CameraScreen(),
    );
  }
}

void main() => runApp(const CameraApp());
