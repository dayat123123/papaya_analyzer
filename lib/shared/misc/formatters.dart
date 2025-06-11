import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';

class Formatters {
  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
  }

  static String formatTimeOnly(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String formatAccuracy(double value) {
    return "${(value * 100).toStringAsFixed(2)}%";
  }

  static String formatSelectedResultName(ClassesResult selected) {
    return switch (selected) {
      ClassesResult.rot => "Rot",
      ClassesResult.ripe => "Ripe",
      ClassesResult.semiRipe => "Semi Ripe",
      ClassesResult.unripe => "Unripe",
    };
  }

  static String formatSelectedResultNameTranslate(ClassesResult selected) {
    return switch (selected) {
      ClassesResult.rot => "Busuk",
      ClassesResult.ripe => "Matang",
      ClassesResult.semiRipe => "Setengah Matang",
      ClassesResult.unripe => "Mentah",
    };
  }

  static Color colorAccuracy(BuildContext context, double acc) {
    if (acc > 75) {
      return (context.themeColors.success);
    } else if (acc < 75 && acc > 50) {
      return (context.themeColors.warning);
    } else {
      return (context.themeColors.failed);
    }
  }

  static String getImagePath(ClassesResult result) {
    return switch (result) {
      ClassesResult.rot => FilePaths.busukJpeg,
      ClassesResult.ripe => FilePaths.masakJpeg,
      ClassesResult.semiRipe => FilePaths.setengahJpeg,
      ClassesResult.unripe => FilePaths.mentahJpeg,
    };
  }

  static String getCiri(ClassesResult result) {
    return switch (result) {
      ClassesResult.rot =>
        "Kulit cokelat atau hitam, lembek berair, aroma asam menyengat, bisa muncul jamur",
      ClassesResult.ripe =>
        "Kulit kuning merata, daging buah lunak, aroma manis kuat",
      ClassesResult.semiRipe =>
        "Kulit mulai menguning sebagian, daging agak lunak, muncul sedikit aroma manis",
      ClassesResult.unripe =>
        "Kulit hijau pekat, daging buah keras, tidak mengeluarkan aroma manis",
    };
  }

  static String getKeterangan(ClassesResult result) {
    return switch (result) {
      ClassesResult.rot =>
        "Tidak layak dikonsumsi, biasanya mulai mengalami fermentasi atau fermentasi",
      ClassesResult.ripe =>
        "Ideal untuk dikonsumsi langsung karena rasa manis dan tekstur yang optimal",
      ClassesResult.semiRipe =>
        "Cocok untuk proses memasak lebih lanjut atau digunakan untuk makanan tertentu",
      ClassesResult.unripe =>
        "Buah pada tahap ini belum layak dikonsumsi langsung dan biasanya digunakan untuk dibikin sayuran",
    };
  }

  static List<String> getDeskripsi(ClassesResult result) {
    return switch (result) {
      ClassesResult.rot => [
        "❌ Tidak layak dikonsumsi",
        "🧪 Mulai mengalami fermentasi",
        "😷 Berpotensi membahayakan kesehatan",
      ],
      ClassesResult.ripe => [
        "✅ Ideal untuk dikonsumsi langsung",
        "🍯 Rasa manis dan tekstur optimal",
        "🍽️ Cocok untuk dinikmati sebagai buah segar",
      ],
      ClassesResult.semiRipe => [
        "🟡 Kulit sebagian menguning",
        "🍳 Cocok untuk proses memasak lebih lanjut",
        "🥗 Bisa digunakan untuk makanan tertentu seperti rujak atau tumisan",
      ],
      ClassesResult.unripe => [
        "🟩 Warna kulit hijau sepenuhnya",
        "🪨 Keras saat ditekan",
        "⛔ Belum layak dikonsumsi langsung",
      ],
    };
  }
}
