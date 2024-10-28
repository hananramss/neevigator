import 'package:flutter/material.dart';
import 'dart:io'; // Import this for File

class DisplayScreen extends StatelessWidget {
  final String imagePath;

  const DisplayScreen({Key? key, required this.imagePath}) : super(key: key); // Pass the key to the superclass

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Image.file(
          File(imagePath), // Use the file from the passed path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
