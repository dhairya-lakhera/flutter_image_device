import 'package:flutter/material.dart';
import 'package:flutter_images/examples/image_camera.dart';
import 'package:flutter_images/examples/image_gallery.dart';
import 'package:flutter_images/examples/multiple_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(child: PageIndex()),
    );
  }
}

class PageIndex extends StatefulWidget {
  const PageIndex({Key? key}) : super(key: key);

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SingleImageGallery()),
                );
              },
              child: Text('Single image using gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SingleImageCamera()),
                );
              },
              child: Text('Single image using camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MultipleImageGallery()),
                );
              },
              child: Text('Multiple images using gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
//'/data/user/0/com.example.flutter_images/app_flutter/339d289f-e31f-4d2e-9e47-07fae1dde7ac4949518979361049480.jpg'
