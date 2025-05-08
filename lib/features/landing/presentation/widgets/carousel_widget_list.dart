import 'package:flutter/material.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';

class CarouselWidgetList {
  static List<Widget> listWidget = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l1Jpeg),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l2Jpeg),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.h1Jpeg),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.h2Jpeg),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.h3Jpeg),
        ),
      ),
    ),
  ];
}
