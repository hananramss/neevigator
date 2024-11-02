// import 'dart:io';
// import 'package:flutter/material.dart';
//
// class DisplayScreen extends StatefulWidget {
//   final File imageFile;
//   final String label;
//   final double confidence;
//
//   const DisplayScreen({
//     Key? key,
//     required this.imageFile,
//     required this.label,
//     required this.confidence,
//   }) : super(key: key);
//
//   @override
//   DisplayScreenState createState() => DisplayScreenState();
// }
//
// class DisplayScreenState extends State<DisplayScreen> {
//   late Future<void> _loadingFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadingFuture = _simulateLoading();
//   }
//
//   Future<void> _simulateLoading() async {
//     // Simulate a network or processing delay
//     await Future.delayed(const Duration(seconds: 2));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Result"),
//       ),
//       body: Center(
//         child: FutureBuilder<void>(
//           future: _loadingFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // While loading, show a CircularProgressIndicator
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               // Handle errors
//               return const Text("Error loading data");
//             } else {
//               // Data is loaded, show the image and results
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.file(
//                     widget.imageFile,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     "Label: ${widget.label}",
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Confidence: ${widget.confidence.toStringAsFixed(0)}%",
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayScreen extends StatefulWidget {
  final File imageFile;
  final String label;
  final double confidence;

  const DisplayScreen({
    Key? key,
    required this.imageFile,
    required this.label,
    required this.confidence,
  }) : super(key: key);

  @override
  DisplayScreenState createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen> {
  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    // Simulate a network or processing delay
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _saveInfo() async {
    try {
      // Create a reference to the Firestore collection
      CollectionReference results = FirebaseFirestore.instance.collection('neevigator');

      // Add the data to the collection
      await results.add({
        'label': widget.label,
        'confidence': widget.confidence,
        'timestamp': FieldValue.serverTimestamp(),
        // You may want to save the image URL after uploading to Firebase Storage
        // 'imageUrl': await uploadImageToStorage(widget.imageFile), // Implement this if needed
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Results saved successfully!")),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _loadingFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While loading, show a CircularProgressIndicator
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle errors
              return const Text("Error loading data");
            } else {
              // Data is loaded, show the image and results
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    widget.imageFile,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Label: ${widget.label}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Confidence: ${widget.confidence.toStringAsFixed(2)}%",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveInfo,
                    child: const Text("Save Info"),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
