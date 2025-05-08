// import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:papayas_analyzer/core/result/result.dart';
// import 'package:papayas_analyzer/shared/misc/file_paths.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// enum PapayaClasses { unripe, semiripe, ripe, overripe }

// enum AppleBanana { apple, banana }

// class Tensorflow {
//   Tensorflow();

//   Interpreter? _interpreter;

//   Future<void> loadTFLiteModel() async {
//     _interpreter = await Interpreter.fromAsset(FilePaths.modelTFLite);
//   }

//   Future<Result<PapayaClasses>> analyzeData(File file) async {
//     if (_interpreter == null) return Result.failed("Interpreter not loaded");

//     try {
//       final bytes = await file.readAsBytes();
//       final image = img.decodeImage(bytes);
//       if (image == null) return Result.failed("Cannot decode image");

//       const inputSize = 224;
//       final resized = img.copyResize(
//         image,
//         width: inputSize,
//         height: inputSize,
//       );

//       // Menyiapkan input untuk model
//       final input = List.generate(inputSize, (y) {
//         return List.generate(inputSize, (x) {
//           final pixel = resized.getPixel(x, y);

//           // Mengambil nilai komponen warna dari pixel
//           final r = img.getRed(pixel); // Mengambil komponen merah
//           final g = img.getGreen(pixel); // Mengambil komponen hijau
//           final b = img.getBlue(pixel); // Mengambil komponen biru

//           // Menormalisasi nilai RGB (0 hingga 255 menjadi 0.0 hingga 1.0)
//           return [r / 255.0, g / 255.0, b / 255.0];
//         });
//       });

//       final modelInput = [input];
//       final output = List.filled(4, 0.0).reshape([1, 4]);

//       // Melakukan inferensi
//       _interpreter!.run(modelInput, output);

//       // Menentukan kelas prediksi
//       final result = output[0];
//       final maxIndex = result.indexWhere(
//         (e) => e == result.reduce((a, b) => a > b ? a : b),
//       );

//       final predictedClass = PapayaClasses.values[maxIndex];
//       return Result.success(predictedClass);
//     } catch (e) {
//       return Result.failed("Inference failed: $e");
//     }
//   }
// }

import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:papayas_analyzer/core/local_storage/local_storage.dart';
import 'package:papayas_analyzer/core/result/result.dart';
import 'package:papayas_analyzer/features/history/presentation/bloc/history_bloc.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';
import 'package:papayas_analyzer/shared/misc/local_storage_keys.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';

class Tensorflow {
  static const int _inputSize = 224;
  static const double _confidenceThreshold = 0.6;
  static const double _maxConfidenceThreshold = 0.8;
  static final int _numClasses = ClassesResult.values.length;

  final LocalStorage _localStorage;
  static final String _key = LocalStorageKeys.historyTensorFlow;
  Tensorflow(this._localStorage);

  Interpreter? _interpreter;

  Future<void> loadTFLiteModel() async {
    _interpreter = await Interpreter.fromAsset(FilePaths.modelTFLite);
  }

  Future<Result<ResultClassModel>> analyzeData(File file) async {
    if (_interpreter == null) return Result.failed("Interpreter belum dimuat");

    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null)
        return Result.failed("Tidak bisa decode gambar, gambar kosong");

      final resized = img.copyResize(
        image,
        width: _inputSize,
        height: _inputSize,
      );

      final input = List.generate(_inputSize, (y) {
        return List.generate(_inputSize, (x) {
          final pixel = resized.getPixel(x, y);
          final r = img.getRed(pixel);
          final g = img.getGreen(pixel);
          final b = img.getBlue(pixel);
          return [r / 255.0, g / 255.0, b / 255.0];
        });
      });

      final modelInput = [input];

      final output = List.filled(_numClasses, 0.0).reshape([1, _numClasses]);

      _interpreter!.run(modelInput, output);
      final result = (output[0] as List).cast<double>();

      final maxConfidence = result.reduce((a, b) => a > b ? a : b);

      final sorted = List<double>.from(result)..sort((a, b) => b.compareTo(a));
      final secondMaxConfidence = sorted.length > 1 ? sorted[1] : 0.0;

      if ((maxConfidence - secondMaxConfidence).abs() < _confidenceThreshold ||
          maxConfidence < _maxConfidenceThreshold) {
        return Result.failed("Diluar distribusi gambar (OOD)");
      }

      final maxIndex = result.indexOf(maxConfidence);
      final predictedClass = ClassesResult.values[maxIndex];

      final analyzedResult = ResultClassModel(
        maxConfidence,
        predictedClass,
        file, // Menyimpan file secara langsung
        DateTime.now(),
      );

      await saveHistoryTensorflow(analyzedResult);

      return Result.success(analyzedResult);
    } catch (e) {
      return Result.failed("Inference gagal: $e");
    }
  }

  Future<void> saveHistoryTensorflow(ResultClassModel result) async {
    try {
      final existingData = await _localStorage.getData(_key);

      List<ResultClassModel> history = [];

      if (existingData != null) {
        final List<dynamic> decodedList = existingData;
        history =
            decodedList
                .map(
                  (e) => ResultClassModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();
      }

      history.insert(0, result);

      final encodedList = history.map((e) => e.toJson()).toList();
      await _localStorage.setData(_key, encodedList);
      getHistoryBloc.add(AddNewHistory(result));
    } catch (e) {
      print("Error saveHistoryTensorFlow: ${e.toString()}");
    }
  }

  Future<List<ResultClassModel>> loadHistoryData() async {
    List<ResultClassModel> history = [];
    try {
      final existingData = await _localStorage.getData(_key);
      if (existingData != null) {
        final List<dynamic> decodedList = existingData;
        history =
            decodedList
                .map(
                  (e) => ResultClassModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();
      }
      return history;
    } catch (e) {
      print("Error loadHistoryData: ${e.toString()}");
      return history;
    }
  }

  Future<void> clearHistories() async {
    try {
      await _localStorage.removeData(_key);
    } catch (e) {
      print("Error clearHistories: ${e.toString()}");
    }
  }
}

enum ClassesResult { apple, banana }

class ResultClassModel {
  final double accuracy;
  final ClassesResult selected;
  final File imageFile;
  final DateTime lastUpdated;

  const ResultClassModel(
    this.accuracy,
    this.selected,
    this.imageFile,
    this.lastUpdated,
  );

  Map<String, dynamic> toJson() {
    final imageBytes = imageFile.readAsBytesSync();
    return {
      'accuracy': accuracy,
      'selected': selected.name,
      'imageBytes': base64Encode(imageBytes),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory ResultClassModel.fromJson(Map<String, dynamic> json) {
    final imageBytes = base64Decode(json['imageBytes']);
    final tempFile = File('${Directory.systemTemp.path}/temp_image');
    tempFile.writeAsBytesSync(imageBytes);

    return ResultClassModel(
      (json['accuracy'] as num).toDouble(),
      ClassesResult.values.byName(json['selected']),
      tempFile,
      DateTime.parse(json['lastUpdated']),
    );
  }
}
