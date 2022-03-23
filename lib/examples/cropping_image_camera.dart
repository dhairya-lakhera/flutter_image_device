import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class CroppingImageCamera extends StatefulWidget {
  const CroppingImageCamera({Key? key}) : super(key: key);

  @override
  State<CroppingImageCamera> createState() => _CroppingImageCameraState();
}

class _CroppingImageCameraState extends State<CroppingImageCamera> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (imageFile == null) return;

    // getApplicationDocumentsDirectory() function provided by import 'package:path_provider/path_provider.dart'
    //final appDir = await getApplicationDocumentsDirectory();
    //final fileName = path.basename(imageFile.path);

    //Saving image from temp cache to permanent path on device. Once the image is save on device it can be used later. savedImage variable will hold the complete path of saved image on device
    //final savedImage = await File(imageFile.path).copy('${appDir.path}/${fileName}');

    File croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )) as File;

    setState(() {
      _storedImage = croppedFile;
      print('setSatecalled================');
    });

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
