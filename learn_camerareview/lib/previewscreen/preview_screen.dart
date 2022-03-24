// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  // ignore: use_key_in_widget_constructors
  const PreviewImageScreen({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        backgroundColor: Colors.blueGrey,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            const SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(60.0),
                child: RaisedButton(
                  onPressed: () {
                    share();
                    // getBytesFromFile().then((bytes) {
                    //   Share.file('Share via:', basename(widget.imagePath),
                    //       bytes.buffer.asUint8List(), 'image/png');
                    // });
                  },
                  child: const Text('Share'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> shareFile(path) async {
    await FlutterShare.shareFile(
        title: 'Example share', text: 'Example share text', filePath: path);
  }
}
