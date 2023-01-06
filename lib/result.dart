import 'dart:typed_data';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(this.img, {Key? key}) : super(key: key);

  final Uint8List img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('result'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.memory(
          img
        ),
      ),
    );
  }
}
