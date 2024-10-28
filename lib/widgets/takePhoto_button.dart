import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:neevigatorv2/screens/display_screen.dart'; // Import this for File

class TakePhotoButton extends StatefulWidget {
  const TakePhotoButton({Key? key}) : super(key: key);

  @override
  TakePhotoButtonState createState() => TakePhotoButtonState();
}

class TakePhotoButtonState extends State<TakePhotoButton> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });

    // Navigate to another page to display the image if taken
    if (_image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayScreen(imagePath: _image!.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _takePhoto,
      child: const Text('Take Photo'),
    );
  }
}