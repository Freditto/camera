import 'dart:io';

import 'package:camera/helper/database.dart';
import 'package:flutter/material.dart';

class SingleImagePage extends StatefulWidget {
  final int id;
  final File imageUrl;

  SingleImagePage({required this.imageUrl, required this.id});

  @override
  State<SingleImagePage> createState() => _SingleImagePageState();
}

class _SingleImagePageState extends State<SingleImagePage> {

  _deleteImageDialog(BuildContext context, int id, String path) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Image'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: const Text(
                    "Are you sure you want to delete this image",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () async {
                            // _deleteSingleProductTocart(index);
                            // logOUT_User();
                                    final dbHelper = DBHelper();
                                    final imagesData =
                                        await dbHelper.deleteImage(id);
                            deleteImage(path);

                            Navigator.of(context).pop();
                            
                          },
                          child: const Text('Yes')),

                      const SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  void deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        print('Image deleted successfully');
      } else {
        print('Image not found');
      }
    } catch (e) {
      print('Failed to delete image: $e');
    }
  }



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Single Image Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       _deleteImageDialog(context, widget.id);
          //       // Add your logic for adding to favorites here
          //     },
          //     child: Text(''),
          //   ),
          // ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _deleteImageDialog(context, widget.id, widget.imageUrl.path);
        },
        child: Icon(Icons.delete_outline),
        backgroundColor: Colors.amberAccent,

        ),
    );
  }
}
