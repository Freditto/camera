import 'dart:io';

import 'package:camera/gallery.dart';
import 'package:camera/helper/database.dart';
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

        final dbHelper = DBHelper();
        var data = {"path": _imagepath!, "is_favourite": false};
        final historydata = await dbHelper.insertImages(data);
        
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  

  
  _chooseDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Choose'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  // Number of columns in the grid
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        openCamera();
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                              ), // Replace 'icon_name_3' with the desired icon
                              SizedBox(height: 8),
                              Text(
                                'Camera',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GalleryPage()),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 50,
                              ), // Replace 'icon_name_3' with the desired icon
                              SizedBox(height: 8),
                              Text(
                                'Gallery',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: const BoxDecoration(
        // color: AppColor.defaultcard,
        image: DecorationImage(
            image: AssetImage("assets/bgx.png"),
            // image: NetworkImage(
            // "https://images.pexels.com/photos/5208356/pexels-photo-5208356.jpeg?auto=compress&cs=tinysrgb&w=1600"),
            fit: BoxFit.cover),
        // Fit(),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.menu),
          onPressed: () {
            _chooseDialog(context);
          }),
    );
  }
}
