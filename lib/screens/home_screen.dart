import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;
import 'display_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Add a method to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  File? filePath;
  String label = '';
  double confidence = 0.0;

  Future<void> _tfLteInit() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );

    devtools.log("Model load result: $res");  // Log the result for debugging
  }


  // Future<void> _tfLteInit() async {
  //   String? res = await Tflite.loadModel(
  //     model: "assets/model_unquant.tflite",
  //     labels: "assets/labels.txt",
  //     numThreads: 1,
  //     isAsset: true,
  //     useGpuDelegate: false, //Enable GPU: If the device supports it,
  //   );
  // }

  // pickImageGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image == null) return;
  //
  //   var imageMap = File(image.path);
  //
  //   var recognitions = await Tflite.runModelOnImage(
  //     path: image.path,
  //     imageMean: 0.0,
  //     imageStd: 255.0,
  //     numResults: 2,
  //     threshold: 0.5, // Adjust to find the optimal balance between false positives and negatives
  //     asynch: true, //
  //   );
  //
  //   if (recognitions == null || recognitions.isEmpty) {
  //     devtools.log("No recognitions found.");
  //     return;
  //   }
  //
  //   devtools.log(recognitions.toString());
  //   setState(() {
  //     confidence = (recognitions[0]['confidence'] * 100);
  //     label = recognitions[0]['label'].toString();
  //   });
  //
  //   // Navigate to the Result Page
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DisplayScreen(
  //         imageFile: imageMap,
  //         label: label,
  //         confidence: confidence,
  //       ),
  //     ),
  //   );
  // }

  // pickImageCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (image == null) return;
  //
  //   var imageMap = File(image.path);
  //
  //   var recognitions = await Tflite.runModelOnImage(
  //     path: image.path,
  //     imageMean: 0.0,
  //     imageStd: 255.0,
  //     numResults: 2,
  //     threshold: 0.2,
  //     asynch: true,
  //   );
  //
  //   if (recognitions == null || recognitions.isEmpty) {
  //     devtools.log("No recognitions found.");
  //     return;
  //   }
  //
  //   devtools.log(recognitions.toString());
  //   setState(() {
  //     confidence = (recognitions[0]['confidence'] * 100);
  //     label = recognitions[0]['label'].toString();
  //   });
  //
  //   // Navigate to the Result Page
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DisplayScreen(
  //         imageFile: imageMap,
  //         label: label,
  //         confidence: confidence,
  //       ),
  //     ),
  //   );
  // }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        devtools.log("No image selected.");
        return;
      }

      var imageMap = File(image.path);

      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.5,
        asynch: true,
      );

      if (recognitions == null || recognitions.isEmpty) {
        devtools.log("No recognitions found.");
        return;
      }

      devtools.log(recognitions.toString());
      if (mounted) {  // Check if the widget is still mounted before calling setState
        setState(() {
          confidence = (recognitions[0]['confidence'] * 100);
          label = recognitions[0]['label'].toString();
        });
      }

      if (mounted) {  // Check again before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayScreen(
              imageFile: imageMap,
              label: label,
              confidence: confidence,
            ),
          ),
        );
      }
    } catch (e) {
      devtools.log("Error picking image from gallery: $e");
      if (mounted) {  // Check if the widget is still mounted before showing a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to pick image from gallery.")),
        );
      }
    }
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image == null) {
        devtools.log("No image captured.");
        return;
      }

      var imageMap = File(image.path);

      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
      );

      if (recognitions == null || recognitions.isEmpty) {
        devtools.log("No recognitions found.");
        return;
      }

      devtools.log(recognitions.toString());
      if (mounted) {  // Check if the widget is still mounted before calling setState
        setState(() {
          confidence = (recognitions[0]['confidence'] * 100);
          label = recognitions[0]['label'].toString();
        });
      }

      if (mounted) {  // Check again before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayScreen(
              imageFile: imageMap,
              label: label,
              confidence: confidence,
            ),
          ),
        );
      }
    } catch (e) {
      devtools.log("Error capturing image from camera: $e");
      if (mounted) {  // Check if the widget is still mounted before showing a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to capture image from camera.")),
        );
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfLteInit();
  }

  void _showDiagnoseOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an Option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  pickImageCamera();
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Take a Photo"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  pickImageGallery();
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Select Photo"),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NEEvigator"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Show the dialog when "Start Diagnose" is pressed
                  _showDiagnoseOptionsDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Start Diagnose"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner), // Icon for 'Diagnose'
            label: 'Diagnose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save), // Icon for 'Data'
            label: 'Data',
          ),
        ],
      ),
    );
  }
}

