import 'package:flutter/material.dart';
import 'Image_picker/image_picker_screen.dart';
import 'camerascreen/camera_screen.dart';

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Picker Demo',
      home: ImagePickerPage(title: 'App Demo'),
    );
  }
}

void main() => runApp(const CameraApp());
