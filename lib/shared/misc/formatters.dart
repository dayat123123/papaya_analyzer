import 'package:intl/intl.dart';

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
}
