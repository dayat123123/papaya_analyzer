import 'dart:io';

import 'package:flutter/material.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewWidget extends StatelessWidget {
  final File imageFile;

  const FullScreenImageViewWidget({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Gambar")),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
          backgroundDecoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
