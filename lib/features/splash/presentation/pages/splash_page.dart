import 'package:flutter/material.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      getRouter.go(RoutePath.homePath);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          height: 200,
          width: 200,
          FilePaths.splashPng,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
