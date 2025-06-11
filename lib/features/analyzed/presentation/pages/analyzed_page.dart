import 'package:papayas_analyzer/shared/misc/formatters.dart';
import 'package:flutter/material.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';

class AnalyzedPage extends StatefulWidget {
  final ResultClassModel result;
  const AnalyzedPage({super.key, required this.result});

  @override
  State<AnalyzedPage> createState() => _AnalyzedPageState();
}

class _AnalyzedPageState extends State<AnalyzedPage> {
  void _onTapPreview() {
    getRouter.push(
      RoutePath.fullScreenImageViewPath,
      extra: widget.result.imageFile,
    );
  }

  void _onTapNewFoto() {
    getRouter.push(RoutePath.imagePickerPath);
  }

  @override
  Widget build(BuildContext context) {
    final deskripsi = Formatters.getDeskripsi(widget.result.selected);
    final bool isDark = getAppThemeCubit.isDarkMode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      backgroundColor: isDark ? null : context.themeColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.fullHeight * 0.4 + 50,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackground(context),
                Positioned(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  child: CardContainer(
                    alignment: Alignment.centerLeft,
                    padding: AppPadding.all,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hasil deteksi:",
                          style: context.textStyle.appbarTitle,
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "     ${Formatters.formatSelectedResultName(widget.result.selected)} (${Formatters.formatSelectedResultNameTranslate(widget.result.selected)})",
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "Tingkat Keyakinan: ${Formatters.formatAccuracy(widget.result.accuracy)}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Padding(
            padding: AppPadding.all,
            child: Text("Deskripsi:", style: context.textStyle.appbarTitle),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: AppPadding.horizontal,
            itemBuilder: (context, index) {
              return Text(deskripsi[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 6.0),
            itemCount: deskripsi.length,
          ),

          Spacer(),
          Center(
            child: CardContainer(
              onTap: _onTapNewFoto,
              color: context.themeColors.primaryColor,
              width: context.fullWidth * 0.9,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: context.themeColors.whiteColor),
                  SizedBox(width: 8.0),
                  Text(
                    "Ambil Foto Baru",
                    style: TextStyle(
                      color: context.themeColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(backgroundColor: Colors.transparent, elevation: 0);
  }

  Widget _buildBackground(BuildContext context) {
    return GestureDetector(
      onTap: _onTapPreview,
      child: Container(
        height: context.fullHeight * 0.4,
        width: context.fullWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(widget.result.imageFile),
          ),
        ),
      ),
    );
  }
}
