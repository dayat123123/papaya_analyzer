import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:papayas_analyzer/core/result/result.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    if (mounted) context.pop();
  }

  void _showImageSourceActionSheet() {
    context.showBottomSheet(
      isScrollControlled: false,
      child: SafeArea(
        child: Padding(
          padding: AppPadding.all,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera, color: Colors.blue),
                title: Text('Pilih gambar dari kamera'),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.green),
                title: Text('Pilih gambar dari galery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapAnalize(File file) async {
    context.showLoadingDialog(isDismissible: false);
    await Future.delayed(Duration(seconds: 1));
    final result = await getTensorflow.analyzeData(file);
    if (mounted) context.pop();
    if (result is Success) {
      final data = result.resultValue!;
      getRouter.push(RoutePath.analyzedPath, extra: data);
    } else {
      if (mounted) {
        context.showToast(
          context: context,
          position: ToastPosition.top,
          status: ToastStatus.failed,
          title: "Gagal",
          subtitle: result.errorMessage ?? "",
        );
      }
    }
  }

  void _onTapPreview() {
    getRouter.push(RoutePath.fullScreenImageViewPath, extra: _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Gambar")),
      body: Padding(
        padding: AppPadding.all,
        child: Column(
          children: [
            Text(
              "Gambar ini akan digunakan untuk pengujian model machine learning untuk mendeteksi gambar dengan model yang dibuat menggunakan algoritma CNN",
              style: context.textStyle.body.copyWith(fontSize: 14),
              textAlign: TextAlign.start,
            ),
            Expanded(child: _imageWidget()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showImageSourceActionSheet,
        label: const Text("Pilih Gambar"),
        icon: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _imageWidget() {
    return _selectedImage != null
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _onTapPreview,
              child: Container(
                height: 250,
                width: 250,
                padding: AppPadding.all,
                decoration: BoxDecoration(
                  border: Border.all(color: context.themeColors.border),
                  borderRadius: AppBorderRadius.large,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(_selectedImage!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CardContainer(
              height: 50,
              width: context.fullWidth * 0.6,
              onTap: () {
                _onTapAnalize(_selectedImage!);
              },
              borderRadius: AppBorderRadius.smallNumber,
              color: context.themeColors.primaryColor,
              child: Text(
                "Analisis Gambar",
                style: context.textStyle.title.copyWith(
                  color: context.themeColors.whiteColor,
                ),
              ),
            ),
          ],
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 100, color: context.themeColors.hintColor),
            const SizedBox(height: 10),
            Text(
              "Belum ada gambar yang terpilih",
              style: context.textStyle.body.copyWith(
                color: context.themeColors.hintColor,
              ),
            ),
          ],
        );
  }
}
