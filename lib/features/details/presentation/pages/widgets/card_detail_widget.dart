import 'package:flutter/material.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/misc/formatters.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';

class CardDetailWidget extends StatelessWidget {
  final ClassesResult item;
  const CardDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: context.fullWidth * 0.35,
              child: Image.asset(
                Formatters.getImagePath(item),
                fit: BoxFit.cover,
              ),
            ),

            Flexible(
              child: Padding(
                padding: AppPadding.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "${Formatters.formatSelectedResultName(item)}(${Formatters.formatSelectedResultNameTranslate(item)})",
                        textAlign: TextAlign.center,
                        style: context.textStyle.title,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text("Ciri-Ciri:"),
                    const SizedBox(height: 4.0),
                    Text(
                      Formatters.getCiri(item),
                      style: context.textStyle.label,
                    ),
                    const SizedBox(height: 8.0),
                    const Text("Keterangan:"),
                    const SizedBox(height: 4.0),
                    Text(
                      Formatters.getKeterangan(item),
                      style: context.textStyle.label,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
