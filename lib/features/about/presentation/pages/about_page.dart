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
                    ItemWidgetContainer(
                      title: "Nama",
                      subtitle: "Asma Rosnaida",
                    ),
                    ItemWidgetContainer(
                      title: "Universitas",
                      subtitle: "Universitas Islam Indragiri",
                    ),
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
                      subtitle: "4 Class (unripe, semi ripe, ripe, rot)",
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
                    ItemWidgetContainer(title: "Epochs", subtitle: "30 Epoch"),
                    ItemWidgetContainer(
                      title: "Akurasi Training",
                      subtitle: "88.46 %",
                    ),
                    ItemWidgetContainer(
                      title: "Area under curve (AUC)",
                      subtitle: "0.977",
                    ),
                    ItemWidgetContainer(
                      title: "Precision (avg)",
                      subtitle:
                          "Rot: 0.97\nRipe: 0.82\nSemi Ripe: 0.77\nUnripe: 0.93",
                    ),
                    ItemWidgetContainer(
                      title: "Recall (avg)",
                      subtitle:
                          "Rot: 0.84\nRipe: 0.84\nSemi Ripe: 0.79\nUnripe: 1",
                    ),
                    ItemWidgetContainer(
                      title: "F1-score (avg)",
                      subtitle:
                          "Rot: 0.9\nRipe: 0.83\nSemi Ripe: 0.78\nUnripe: 0.96",
                    ),
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
