import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:w2img/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'w2img',
      home: const MyHomePage(title: 'w2img'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  late Uint8List img;

  Future<Uint8List> _capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          RepaintBoundary(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Example Text',
                    style: TextStyle(color: Colors.deepOrange)),
              )),
          TextButton(
            onPressed: () async {
              Uint8List img = await _capturePng();
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Result(img),
                  ),
                );
              }
            },
            child: const Text('Cheese', textDirection: TextDirection.ltr),
          ),
        ],
      )),
    );
  }
}
