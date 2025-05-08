import 'package:flutter/material.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/shared/widgets/container/item_widget_container.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: AppPadding.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerWithSubItem(
                  title: "Creator",
                  listWidget: [
                    ItemWidgetContainer(title: "Nama", subtitle: "23323"),
                  ],
                ),
                SizedBox(height: 20),
                ContainerWithSubItem(
                  title: "Overview Model",
                  listWidget: [
                    ItemWidgetContainer(
                      title: "Model",
                      subtitle: "Mobile Net V2",
                    ),
                    ItemWidgetContainer(
                      title: "Algoritma",
                      subtitle: "CNN (Convolutional Neural Network)",
                    ),
                    ItemWidgetContainer(
                      title: "Ukuran Input Gambar",
                      subtitle: "224 x 224",
                    ),
                    ItemWidgetContainer(
                      title: "Jumlah Class",
                      subtitle: "4 Class (unripe, semi ripe, ripe, overripe)",
                    ),
                    ItemWidgetContainer(
                      title: "Optimiasasi",
                      subtitle:
                          "Adam optimizer, learning rate 0.0001, dropout 0.5",
                    ),
                    ItemWidgetContainer(
                      title: "Augmentasi",
                      subtitle: "Rotasi, zoom, putar, normalisasi",
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ContainerWithSubItem(
                  title: "Training Model",
                  listWidget: [
                    ItemWidgetContainer(title: "Epochs", subtitle: "30 Epochs"),
                    ItemWidgetContainer(
                      title: "Akurasi Training",
                      subtitle: "0.982",
                    ),
                    ItemWidgetContainer(
                      title: "Akurasi Validation",
                      subtitle: "0.956",
                    ),
                    ItemWidgetContainer(title: "Loss", subtitle: "0.956"),
                    ItemWidgetContainer(title: "Val Loss", subtitle: "0.956"),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
