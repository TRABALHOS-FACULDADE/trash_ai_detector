import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../../core/app_constants.dart';
import '../../domain/models/enums/e_trash_type.dart';
import '../../domain/models/enums/trash_status.dart';
import '../../domain/models/new_e_trash.dart';
import 'e_trashes_view_model.dart';

class TFLiteViewModel {
  late File image;

  double probability = 0;

  String? result;

  List<String>? labels;

  late tfl.Interpreter interpreter;

  final picker = ImagePicker();

  Future<void> loadModel() async {
    try {
      interpreter = await tfl.Interpreter.fromAsset(AppConstants.MODEL_ASSET);
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<Uint8List> preprocessImage() async {
    img.Image? originalImage = img.decodeImage(await image.readAsBytes());

    img.Image resizedImage =
        img.copyResize(originalImage!, width: 224, height: 224);

    Uint8List bytes = resizedImage.getBytes();
    return bytes;
  }

  Future<List<String>> loadLabels(BuildContext context) async {
    final labelsData = await DefaultAssetBundle.of(context).loadString(
      AppConstants.LABELS_ASSET,
    );
    return labelsData.split('\n');
  }

  String classifyImage(List<int> output) {
    int highestProbIndex = output.indexOf(output.reduce(max));
    return labels![highestProbIndex];
  }

  Future<void> runInference() async {
    if (labels == null) return;

    try {
      Uint8List inputBytes = await preprocessImage();
      var input = inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
      var outputBuffer = List<int>.filled(1 * 3, 0).reshape([1, 3]);

      interpreter.run(input, outputBuffer);

      List<int> output = outputBuffer[0];

      debugPrint('Raw output: $output');

      int maxScore = output.reduce(max);

      probability = (maxScore / 255);

      String classificationResult = classifyImage(output);

      result = classificationResult;

      if (kDebugMode) {
        print('Result: $result');
        print('Probability: $probability');
      }

      Modular.get<ETrashesViewModel>().insertNewETrash(
        NewETrash(
          trashType: ETrashType.values.singleWhereOrNull(
                (type) =>
                    type.name.toLowerCase() ==
                    result?.replaceAll(' ', '').toLowerCase(),
              ) ??
              ETrashType.none,
          status: TrashStatus.discarded,
        ),
      );
    } catch (e) {
      debugPrint('Error during inference: $e');
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

  void _setImage(File loadedImage) {
    image = loadedImage;
    runInference();
  }
}
