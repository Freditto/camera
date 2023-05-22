import 'dart:io';

import 'package:camera/helper/database.dart';
import 'package:camera/single_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  @override
  void initState() {
    super.initState();
    // Initialization tasks can be performed here
    // message = 'Welcome to Flutter!';
    _pickImages();
  }
  List<File> _images = [];
  List<int> _ids = [];

  Future<void> _pickImages() async {
    // final imagePicker = ImagePicker();
    // final pickedImages = await imagePicker.pickMultiImage();
    final dbHelper = DBHelper();
    final imagesData = await dbHelper.getImages();


    if (imagesData != null) {
      setState(() {
        _images = imagesData.map((pickedImage) => File(pickedImage['path'])).toList();
        for(var data in imagesData){
          _ids.add(data['id']);
        }
      });
    }
    print(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        itemCount: _images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns as needed
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return InkWell(child: Image.file(_images[index]),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SingleImagePage(id: _ids[index], imageUrl: _images[index])),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pickImages,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
