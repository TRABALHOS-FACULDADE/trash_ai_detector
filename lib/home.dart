import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:trash_ai/result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File _image;

  dynamic _probability = 0;

  String? _result;

  List<String>? _labels;

  late tfl.Interpreter _interpreter;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((_) => loadLabels().then((loadedLabels) => setState(() {
          _labels = loadedLabels;
          if (kDebugMode) {
            print(_labels);
          }
        })));
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 80),
                const Text(
                  'E-Waste Detector App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      fontFamily: 'SofiaSans',
                      fontSize: 30),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImageFromCamera(),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 18),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Capture a Photo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SofiaSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImageFromGallery(),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 18),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Select a photo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SofiaSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await tfl.Interpreter.fromAsset('assets/waste.tflite');
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    _setImage(File(pickedFile.path));
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    _setImage(File(pickedFile.path));
  }

  void _setImage(File image) {
    setState(() => _image = image);
    runInference();
  }

  Future<Uint8List> preprocessImage(File imageFile) async {
    img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());

    img.Image resizedImage =
        img.copyResize(originalImage!, width: 224, height: 224);

    Uint8List bytes = resizedImage.getBytes();
    return bytes;
  }

  Future<void> runInference() async {
    if (_labels == null) return;

    try {
      Uint8List inputBytes = await preprocessImage(_image);
      var input = inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
      var outputBuffer = List<int>.filled(1 * 3, 0).reshape([1, 3]);

      _interpreter.run(input, outputBuffer);

      List<int> output = outputBuffer[0];

      debugPrint('Raw output: $output');

      int maxScore = output.reduce(max);

      _probability = (maxScore / 255);

      String classificationResult = classifyImage(output);

      setState(() => _result = classificationResult);

      navigateToResult();
    } catch (e) {
      debugPrint('Error during inference: $e');
    }
  }

  Future<List<String>> loadLabels() async {
    final labelsData = await DefaultAssetBundle.of(context)
        .loadString('assets/waste_labels.txt');
    return labelsData.split('\n');
  }

  String classifyImage(List<int> output) {
    int highestProbIndex = output.indexOf(output.reduce(max));
    return _labels![highestProbIndex];
  }

  void navigateToResult() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            image: _image,
            result: _result!,
            probability: _probability,
          ),
        ),
      );
}
