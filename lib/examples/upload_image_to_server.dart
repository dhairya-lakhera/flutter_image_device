import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';

class UploadImageToServer extends StatefulWidget {
  const UploadImageToServer({Key? key}) : super(key: key);

  @override
  State<UploadImageToServer> createState() => _UploadImageToServerState();
}

class _UploadImageToServerState extends State<UploadImageToServer> {
  List<File> _storedImage = [];

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images == null) return;

    setState(() {
      for (XFile element in images) {
        _storedImage.add(File(element.path));
      }
    });
  }

  removeImage(index) {
    setState(() {
      _storedImage.removeAt(index);
    });
  }

  Future<void> _uploadImage() async {
    //Header

    //var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    //Request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://dev.reedius.com/api/aaa'),
    );

    for (File element in _storedImage) {
      request.files.add(
          await http.MultipartFile.fromPath('productImage[]', element.path));
    }

    //request.headers.addAll(headers);
    // request.files.add(await http.MultipartFile.fromPath('image',
    //     '/C:/Users/abc/Pictures/Sample/products/61FjVQa2R5L._AC_UL320_.jpg'));
    // request.files.add(await http.MultipartFile.fromPath('image',
    //     '/C:/Users/abc/Pictures/Sample/products/61VhXKvRyEL._AC_UL320_.jpg'));
    // request.files.add(await http.MultipartFile.fromPath('image',
    //     '/C:/Users/abc/Pictures/Sample/products/71IQhIlXKOL._AC_UL320_.jpg'));
    // request.files.add(await http.MultipartFile.fromPath('image',
    //     '/C:/Users/abc/Pictures/Sample/products/81ak0oeXQKL._AC_UL320_.jpg'));
    // request.headers.addAll(headers);

    //print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('200');
      print(await response.stream.bytesToString());
    } else {
      print('error');
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Multiple images using gallery'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _takePicture,
                child: Text('Select images'),
              ),
              SizedBox(
                height: 30,
              ),
              (_storedImage.isEmpty)
                  ? SizedBox(
                      height: 10,
                    )
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: _storedImage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.file(
                                  _storedImage[index],
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                height: 21,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: -12,
                                child: IconButton(
                                  onPressed: () {
                                    removeImage(index);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
              Spacer(),
              SizedBox(
                height: 42,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ));
  }
}
