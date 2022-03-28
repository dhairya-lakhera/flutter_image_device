import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';

class UrlToDeviceImageSave extends StatefulWidget {
  const UrlToDeviceImageSave({Key? key}) : super(key: key);

  @override
  State<UrlToDeviceImageSave> createState() => _UrlToDeviceImageSaveState();
}

class _UrlToDeviceImageSaveState extends State<UrlToDeviceImageSave> {
  File? _storedImage;

  _saveImageFromUrl() async {
    var response = await http.get(Uri.parse(
        'https://tse3.mm.bing.net/th?id=OIP.h4BoQqPX9oXkxX5DQ0ba8wHaE8&pid=Api'));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File('${documentDirectory.path}/imagetest.png');
    file.writeAsBytesSync(response.bodyBytes);
    setState(() {
      _storedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving image from URL to gallery'),
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
              onPressed: _saveImageFromUrl,
              child: Text('Upload image'),
            ),
          ],
        ),
      ),
    );
  }
}
