import 'package:flutter/material.dart';
import 'package:neevigatorv2/screens/welcome_screen.dart';
import 'package:neevigatorv2/widgets/selectPhoto_button.dart';
import 'package:neevigatorv2/widgets/takePhoto_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center all children vertically
        children: <Widget>[
          // Centering the text content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to NEEvigator', // First text widget
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Style for the first text
                ),
                const SizedBox(height: 20), // Add some spacing between the two text widgets
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Set left and right padding
                  alignment: Alignment.center, // Center align the text within the container
                  child: const Text(
                    'A Mobile Application for Detecting Abaca Bunchy Top Virus in Abaca ', // Second text widget
                    style: TextStyle(fontSize: 18), // Style for the second text
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Set left and right padding
                  alignment: Alignment.center, // Center align the text within the container
                  child: const Text(
                    'Select an option to get started:',
                    style: TextStyle(fontSize: 18), // Style for the second text
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                ),
              ],
            ),
          ),
          // Spacing and Buttons
          const SizedBox(height: 40), // Add space between text and buttons
          Padding(
            padding: const EdgeInsets.all(16.0), // Optional padding around the buttons
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to the screen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    );
                  },
                  child: const TakePhotoButton(), // Your custom GetStartedButton widget
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the screen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    );
                  },
                  child: const SelectPhotoButton(), // Your custom SelectPhotoButton widget
                ),
                TextButton(
                  onPressed: () {
                    // Perform some action (e.g., close the app or pop the current screen)
                    Navigator.pop(context);
                  },
                  child: const Text("Close"), // Default Flutter CloseButton
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
