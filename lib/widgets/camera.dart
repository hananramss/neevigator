import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:neevigatorv2/screens/display_screen.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key); // Named key parameter

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? _controller; // Nullable controller
  late Future<void> _initializeControllerFuture; // Initialization future

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Get a list of available cameras
      final cameras = await availableCameras();
      // Select the first camera
      _controller = CameraController(cameras.first, ResolutionPreset.high);
      _initializeControllerFuture = _controller!.initialize(); // Initialize the controller
    } catch (e) {
      debugPrint("Error initializing camera: $e");
      // Handle any camera initialization errors
      // Optionally show an error message to the user
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose only if it's not null
    super.dispose();
  }

  Future<void> takePicture() async {
    if (_controller == null) {
      debugPrint("Camera controller is not initialized");
      return; // Prevent taking a picture if controller is not initialized
    }

    try {
      await _initializeControllerFuture; // Ensure initialization is complete
      final image = await _controller!.takePicture(); // Use ! to access
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayScreen(
            imageFile: File(image.path),
            label: '', // Initial empty label
            confidence: 0.0, // Initial confidence value
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!); // Use ! to access
          } else {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
