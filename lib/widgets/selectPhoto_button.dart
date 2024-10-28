import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neevigatorv2/screens/display_screen.dart';
import 'dart:io'; // Import this for File


class SelectPhotoButton extends StatefulWidget {
  const SelectPhotoButton({Key? key}) : super(key: key);

  @override
  _SelectPhotoButtonState createState() => _SelectPhotoButtonState();
}

class _SelectPhotoButtonState extends State<SelectPhotoButton> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _selectPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _image = photo;
      });
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
      onPressed: _selectPhoto,
      child: const Text('Select Photo'),
    );
  }
}