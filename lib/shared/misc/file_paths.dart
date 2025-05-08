class FilePaths {
  const FilePaths._();
  static const String _rootPath = "assets";
  static const String _imagesPath = "$_rootPath/images";
  static const String _tensorflowPath = "$_rootPath/tensorflow";

  static const String splashPng = "$_imagesPath/splash.png";
  static const String l1Jpeg = "$_imagesPath/l1.jpeg";
  static const String l2Jpeg = "$_imagesPath/l2.jpeg";
  static const String h1Jpeg = "$_imagesPath/h1.jpeg";
  static const String h2Jpeg = "$_imagesPath/h2.jpeg";
  static const String h3Jpeg = "$_imagesPath/h3.jpeg";
  static const String modelTFLite = "$_tensorflowPath/banana_apple.tflite";
}
