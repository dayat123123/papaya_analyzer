import 'dart:io';
import 'package:papayas_analyzer/shared/misc/formatters.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildBackground(context),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.85,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: context.themeColors.appContainerBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: context.themeColors.border,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: context.themeColors.hintColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(child: _buildContent(scrollController)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: CircleAvatar(
          backgroundColor: context.theme.scaffoldBackgroundColor.withValues(
            alpha: 0.5,
          ),
          child: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
              color: context.themeColors.fontColor,
            ),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      title: Text(Formatters.formatSelectedResultName(widget.result.selected)),
    );
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

  Widget _buildContent(ScrollController scrollController) {
    return ListView(
      padding: AppPadding.all,
      shrinkWrap: true,
      controller: scrollController,
      children: [
        Text("Hasil Deteksi:", style: context.textStyle.subtitle),
        Text(
          Formatters.formatSelectedResultName(widget.result.selected),
          style: context.textStyle.title,
        ),
        SizedBox(height: 8.0),
        Text(
          "Tingkat Keyakinan: ${Formatters.formatAccuracy(widget.result.accuracy)}",
          style: context.textStyle.title,
        ),
      ],
    );
  }
}
