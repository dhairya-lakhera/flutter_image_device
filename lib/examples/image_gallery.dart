import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SingleImageGallery extends StatefulWidget {
  const SingleImageGallery({Key? key}) : super(key: key);

  @override
  State<SingleImageGallery> createState() => _SingleImageGalleryState();
}

class _SingleImageGalleryState extends State<SingleImageGallery> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Single image gallery'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: (_storedImage == null)
                    ? Center(child: Text('Image'))
                    : Image.file(_storedImage!),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _takePicture,
                child: Text('Upload image'),
              ),
            ],
          ),
        ));
  }
}
