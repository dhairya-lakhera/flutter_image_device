import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class MultipleImageGallery extends StatefulWidget {
  const MultipleImageGallery({Key? key}) : super(key: key);

  @override
  State<MultipleImageGallery> createState() => _MultipleImageGalleryState();
}

class _MultipleImageGalleryState extends State<MultipleImageGallery> {
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
                child: Text('Upload image'),
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
                      })
            ],
          ),
        ));
  }
}
