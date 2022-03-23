import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class SingleImageCamera extends StatefulWidget {
  const SingleImageCamera({Key? key}) : super(key: key);

  @override
  State<SingleImageCamera> createState() => _SingleImageCameraState();
}

class _SingleImageCameraState extends State<SingleImageCamera> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.camera);

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    // getApplicationDocumentsDirectory() function provided by import 'package:path_provider/path_provider.dart'
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);

    //Saving image from temp cache to permanent path on device. Once the image is save on device it can be used later. savedImage variable will hold the complete path of saved image on device
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/${fileName}');

    // print('temp_path ${_storedImage}');
    // print('appDir ${appDir}');
    // print('fileName ${fileName}');
    // print('savedImage ${savedImage}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Single image using camera'),
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
