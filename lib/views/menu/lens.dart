import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart'; // Added the logger package for logging

class LensPage extends StatefulWidget {
  const LensPage({super.key});

  @override
  LensPageState createState() => LensPageState(); // State class
}

class LensPageState extends State<LensPage> {
  File? _image;
  final picker = ImagePicker();
  String _prediction = 'No prediction yet';
  bool _isPicking = false; // Flag to prevent multiple image picker invocations
  var logger = Logger(); // Logger instance to replace print statements

  // Function to pick image from the gallery
  Future<void> _pickImage() async {
    if (_isPicking) return; // Prevent multiple calls
    setState(() {
      _isPicking = true;
    });
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _predictImage(_image!);
      }
    } finally {
      setState(() {
        _isPicking = false;
      });
    }
  }

  // Function to capture image from the camera
  Future<void> _captureImage() async {
    if (_isPicking) return; // Prevent multiple calls
    setState(() {
      _isPicking = true;
    });
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _predictImage(_image!);
      }
    } finally {
      setState(() {
        _isPicking = false;
      });
    }
  }

  // Function to predict image using Flask API
  Future<void> _predictImage(File image) async {
    final uri = Uri.parse(
        'http://10.0.2.2:8000/predict'); // Adjusted URL for Android emulator

    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final decodedResponse = json.decode(respStr);
        setState(() {
          _prediction = decodedResponse['predicted_class'];
        });
      } else {
        logger
            .e('Error: ${response.reasonPhrase}'); // Replaced print with logger
      }
    } catch (e) {
      logger.e(
          'Error during prediction: $e'); // Log any errors during the API request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit & Veg Recognition'),
      ),
      body: SingleChildScrollView(
        // Added to prevent overflow on smaller screens
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!), // Ensure the image is displayed
              const SizedBox(height: 20),
              Text('Prediction: $_prediction'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              ElevatedButton(
                onPressed: _captureImage,
                child: const Text('Capture Image from Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
