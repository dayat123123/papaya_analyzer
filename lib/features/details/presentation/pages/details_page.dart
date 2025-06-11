import 'package:flutter/material.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/features/details/presentation/pages/widgets/card_detail_widget.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: ListView.separated(
        padding: AppPadding.all,
        itemBuilder: (context, index) {
          return CardDetailWidget(item: ClassesResult.values[index]);
        },
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: ClassesResult.values.length,
      ),
    );
  }
}
