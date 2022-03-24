// ignore_for_file: avoid_print
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../previewscreen/preview_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State {
  late CameraController controller;
  late List cameras;
  late int selectedCameraIdx;
  late String imagePath;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      // ignore: prefer_is_empty
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print("Error: $err.code\nError Message: $err.message");
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
        if (controller.value.hasError) {
          print('Camera error ${controller.value.errorDescription}');
        }
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (!controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w900),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Click To Share',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _cameraPreviewWidget(),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _cameraTogglesRowWidget(),
                  _captureControlRowWidget(context),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }

  Widget _captureControlRowWidget(context) {
    return Expanded(
        child: Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.camera),
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                _onCapturePressed(context);
              })
        ],
      ),
    ));
  }

  Widget _cameraTogglesRowWidget() {
    if (cameras.isEmpty) {
      return const Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
        child: Align(
      alignment: Alignment.centerRight,
      // ignore: deprecated_member_use
      child: FlatButton.icon(
          onPressed: _onSwitchCamera,
          icon: Icon(_getCameraLensIcon(lensDirection)),
          label: Text(lensDirection
              .toString()
              .substring(lensDirection.toString().indexOf('.') + 1))),
    ));
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear_outlined;
      case CameraLensDirection.front:
        return Icons.camera_front_outlined;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  void _onCapturePressed(context) async {
    try {
      final uuid = Uuid();

      final path =
          join((await getTemporaryDirectory()).path, '${uuid.v1()}.png');
      print(path);

      XFile picture = await controller.takePicture();
      picture.saveTo(path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewImageScreen(imagePath: path)));
    } catch (e) {
      print(e);
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);
    print('Error: ${e.code}\n${e.description}');
  }
}
