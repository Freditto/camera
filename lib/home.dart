import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  String? _imagepath;
  String? image_name;
  int uploaded = 0;

  openCamera() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          // imagefiles = pickedfiles;
          _imagepath = pickedfiles.path;
        });
        // uploadImage();

        GallerySaver.saveImage(_imagepath!);
        
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () {
            openCamera();
          }),
    );
  }
}
