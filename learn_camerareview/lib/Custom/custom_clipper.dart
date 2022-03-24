// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final innerRectg = Rect.fromCenter(
        center: center, width: size.width * 0.8, height: size.height * 0.3);

    final directop = Rect.fromLTWH(
        size.width * 0.5, size.height * 0.1, 20, size.height * 0.2);
    final direcbot = Rect.fromLTWH(
        size.width * 0.5, size.height * 0.7, 20, size.height * 0.2);
    //final innerRect = Rect.fromCircle(center: center, radius: size.width * 0.3);

    final roundRect =
        RRect.fromRectAndRadius(innerRectg, const Radius.circular(0.0));
    return Path()
      ..addRRect(roundRect)
      ..addRect(directop)
      ..addRect(direcbot)
      // ..addOval(Rect.fromCircle(
      //     center: const Offset(60, 60), radius: 20)) // quasi emoji :P
      // ..addOval(
      //     Rect.fromCircle(center: Offset(size.width - 60, 60), radius: 20))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
