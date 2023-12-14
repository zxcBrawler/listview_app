import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listview_app/providers/list_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _textController = TextEditingController();
  String? photoPath;
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
              ),
              if (photoPath != null)
                Column(
                  children: [
                    Image.file(
                      File(photoPath!),
                      height: 400,
                      width: 400,
                    ),
                    if (latitude != null && longitude != null)
                      Text(
                        'Photo geoposition: $latitude, $longitude',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () async {
                  await getImageFromCamera();
                },
                child: const Text('Take a photo'),
              ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () async {
                  await getImageFromGallery();
                },
                child: const Text('Choose from gallery'),
              ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () {
                  final listProvider =
                      Provider.of<ListProvider>(context, listen: false);
                  listProvider.addNote(_textController.text,
                      photoPath: photoPath,
                      latitude: latitude,
                      longitude: longitude);
                  Navigator.of(context).pop();
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        photoPath = pickedFile.path;
      });

      LocationData locationData = await Location().getLocation();
      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
      });
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photoPath = pickedFile.path;
      });

      LocationData locationData = await Location().getLocation();
      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
      });
    }
  }
}
