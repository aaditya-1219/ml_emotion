import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/face_detention_controller.dart';
import '../controller/home_controller.dart';
import '../module/face_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Emotion Detection'),
      ),
      body: GetBuilder<HomeController>(
        init: _homeController,
        initState: (_) async {
          await _homeController.loadCamera();
          _homeController.startImageStream();
        },
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                _.cameraController != null &&
                        _.cameraController!.value.isInitialized
                    ? Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: CameraPreview(_.cameraController!))
                    : const Center(child: Text('loading')),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.topCenter,
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'images/${_.faceAtMoment}',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '${_.label}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Use image picker to pick an image from the gallery
      //     final ImagePicker _picker = ImagePicker();
      //     final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      //
      //     if (pickedImage != null) {
      //       // Convert the picked image to InputImage
      //       File imageFile = File(pickedImage.path);
      //       InputImage inputImage = InputImage.fromFile(imageFile);
      //
      //       // Call processImage method on _homeController to process the picked image
      //       await _homeController.processImage(inputImage);
      //     }
      //   },
      //   tooltip: 'Pick Image',
      //   child: const Icon(Icons.image),
      // ),
    );
  }
}
